param([string]$Nombre = '*')
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing
function Esc([string]$s) { [Security.SecurityElement]::Escape($s) }
function Arrow($g,$pen,$a,$b,$open) {
    $ang=[Math]::Atan2($b[1]-$a[1],$b[0]-$a[0]);$len=15;$spread=0.45
    $p1=[Drawing.PointF]::new([single]($b[0]-$len*[Math]::Cos($ang-$spread)),[single]($b[1]-$len*[Math]::Sin($ang-$spread)))
    $p2=[Drawing.PointF]::new([single]($b[0]-$len*[Math]::Cos($ang+$spread)),[single]($b[1]-$len*[Math]::Sin($ang+$spread)))
    $tip=[Drawing.PointF]::new($b[0],$b[1]);$solid=[Drawing.Pen]::new([Drawing.Color]::Black,2)
    $g.DrawLines($solid,[Drawing.PointF[]]@($p1,$tip,$p2));$solid.Dispose()
}
foreach($file in Get-ChildItem -LiteralPath $PSScriptRoot -Filter "$Nombre.json") {
    $m=Get-Content -LiteralPath $file.FullName -Raw -Encoding UTF8 | ConvertFrom-Json
    $bmp=[Drawing.Bitmap]::new(([int]$m.width*2),([int]$m.height*2));$g=[Drawing.Graphics]::FromImage($bmp);$g.ScaleTransform(2,2);$g.SmoothingMode='AntiAlias';$g.TextRenderingHint='AntiAliasGridFit';$g.Clear([Drawing.Color]::White)
    $pen=[Drawing.Pen]::new([Drawing.Color]::Black,2);$dashed=[Drawing.Pen]::new([Drawing.Color]::Black,2);$dashed.DashStyle='Dash'
    $font=[Drawing.Font]::new('Arial',25,[Drawing.FontStyle]::Regular,[Drawing.GraphicsUnit]::Pixel);$small=[Drawing.Font]::new('Arial',21,[Drawing.FontStyle]::Regular,[Drawing.GraphicsUnit]::Pixel);$title=[Drawing.Font]::new('Arial',32,[Drawing.FontStyle]::Bold,[Drawing.GraphicsUnit]::Pixel)
    $fmt=[Drawing.StringFormat]::new();$fmt.Alignment='Center';$fmt.LineAlignment='Center'
    $svg=[Text.StringBuilder]::new();[void]$svg.AppendLine("<svg xmlns='http://www.w3.org/2000/svg' width='$($m.width)' height='$($m.height)' viewBox='0 0 $($m.width) $($m.height)'><rect width='100%' height='100%' fill='white'/><defs><marker id='arrow' markerWidth='12' markerHeight='12' refX='10' refY='5' orient='auto-start-reverse'><path d='M 1 1 L 10 5 L 1 9' fill='none' stroke='black' stroke-width='1.4'/></marker></defs><g font-family='Arial, sans-serif' fill='black'>")
    $g.DrawString($m.title,$title,[Drawing.Brushes]::Black,35,30);[void]$svg.AppendLine("<text x='35' y='57' font-size='32' font-weight='bold'>$(Esc $m.title)</text>")
    $cells=[Text.StringBuilder]::new();[void]$cells.AppendLine('<mxCell id="0"/><mxCell id="1" parent="0"/>')
    [void]$cells.AppendLine("<mxCell id='title' value='$(Esc $m.title)' style='text;html=0;align=left;fontSize=32;fontStyle=1;fontColor=#000000;' vertex='1' parent='1'><mxGeometry x='35' y='25' width='$($m.width-70)' height='50' as='geometry'/></mxCell>")
    foreach($box in $m.groups) {
        $g.DrawRectangle($pen,$box.x,$box.y,$box.w,$box.h);$g.DrawString($box.label,$small,[Drawing.Brushes]::Black,([single]$box.x+12),([single]$box.y+12))
        [void]$svg.AppendLine("<rect x='$($box.x)' y='$($box.y)' width='$($box.w)' height='$($box.h)' fill='none' stroke='black' stroke-width='2'/><text x='$($box.x+12)' y='$($box.y+30)' font-size='21'>$(Esc $box.label)</text>")
        [void]$cells.AppendLine("<mxCell id='$($box.id)' value='$(Esc $box.label)' style='rounded=0;fillColor=#FFFFFF;strokeColor=#000000;fontColor=#000000;verticalAlign=top;align=left;spacingLeft=12;spacingTop=10;fontSize=21;connectable=0;' vertex='1' parent='1'><mxGeometry x='$($box.x)' y='$($box.y)' width='$($box.w)' height='$($box.h)' as='geometry'/></mxCell>")
    }
    foreach($edge in $m.edges) {
        $pts=[Drawing.PointF[]]@($edge.points | ForEach-Object {[Drawing.PointF]::new($_[0],$_[1])});$ep=$pen;if($m.uml){$ep=$dashed};$g.DrawLines($ep,$pts);Arrow $g $pen $edge.points[-2] $edge.points[-1] $m.uml;if($edge.both){Arrow $g $pen $edge.points[1] $edge.points[0] $false}
        $dash='';if($m.uml){$dash="stroke-dasharray='9 6'"};$start='';if($edge.both){$start="marker-start='url(#arrow)'"};$coords=($edge.points | ForEach-Object {"$($_[0]),$($_[1])"}) -join ' '
        [void]$svg.AppendLine("<polyline points='$coords' fill='none' stroke='black' stroke-width='2' $dash marker-end='url(#arrow)' $start/>")
        $geom=[Text.StringBuilder]::new();foreach($p in $edge.points[1..($edge.points.Count-2)]){if($edge.points.Count -gt 2){[void]$geom.Append("<mxPoint x='$($p[0])' y='$($p[1])'/>")}}
        $style='endArrow=open;endFill=0;';if($m.uml){$style+='dashed=1;'};if($edge.both){$style+='startArrow=open;startFill=0;'}
        $a=$edge.points[0];$b=$edge.points[-1]
        [void]$cells.AppendLine("<mxCell id='$($edge.id)' value='' style='edgeStyle=none;rounded=0;strokeColor=#000000;${style}' edge='1' parent='1'><mxGeometry relative='1' as='geometry'><mxPoint x='$($a[0])' y='$($a[1])' as='sourcePoint'/><mxPoint x='$($b[0])' y='$($b[1])' as='targetPoint'/><Array as='points'>$geom</Array></mxGeometry></mxCell>")
    }
    foreach($n in $m.nodes) {
        $g.FillRectangle([Drawing.Brushes]::White,$n.x,$n.y,$n.w,$n.h);$g.DrawRectangle($pen,$n.x,$n.y,$n.w,$n.h)
        [void]$svg.AppendLine("<rect x='$($n.x)' y='$($n.y)' width='$($n.w)' height='$($n.h)' fill='white' stroke='black' stroke-width='2'/>")
        $lines=@($n.text);if($m.uml -and !$n.artifact){$lines=@(([string][char]171+'component'+[char]187))+$lines};if($n.artifact){$lines=@(([string][char]171+'artifact'+[char]187))+$lines}
        $step=30;$first=$n.y+($n.h-($lines.Count-1)*$step)/2
        for($i=0;$i -lt $lines.Count;$i++){$yy=$first+$i*$step;$g.DrawString($lines[$i],$font,[Drawing.Brushes]::Black,[Drawing.RectangleF]::new($n.x,($yy-17),$n.w,34),$fmt);[void]$svg.AppendLine("<text x='$($n.x+$n.w/2)' y='$($yy+8)' font-size='25' text-anchor='middle'>$(Esc $lines[$i])</text>")}
        $value=Esc ($lines -join '&#xa;');$value=$value.Replace('&amp;#xa;','&#xa;')
        [void]$cells.AppendLine("<mxCell id='$($n.id)' value='$value' style='rounded=0;whiteSpace=wrap;html=0;fillColor=#FFFFFF;strokeColor=#000000;fontColor=#000000;fontSize=25;align=center;verticalAlign=middle;' vertex='1' parent='1'><mxGeometry x='$($n.x)' y='$($n.y)' width='$($n.w)' height='$($n.h)' as='geometry'/></mxCell>")
    }
    foreach($edge in $m.edges){$x=$edge.label[0];$y=$edge.label[1];$g.FillRectangle([Drawing.Brushes]::White,($x-24),($y-17),48,34);$g.DrawString($edge.id,$small,[Drawing.Brushes]::Black,[Drawing.RectangleF]::new(($x-24),($y-17),48,34),$fmt);[void]$svg.AppendLine("<rect x='$($x-24)' y='$($y-17)' width='48' height='34' fill='white'/><text x='$x' y='$($y+7)' font-size='21' text-anchor='middle'>$($edge.id)</text>");[void]$cells.AppendLine("<mxCell id='$($edge.id)_label' value='$($edge.id)' style='text;html=0;fillColor=#FFFFFF;fontSize=21;align=center;fontColor=#000000;' vertex='1' parent='1'><mxGeometry x='$($x-24)' y='$($y-17)' width='48' height='34' as='geometry'/></mxCell>")}
    $ny=$m.height-160;$ni=0;foreach($note in $m.notes){$g.DrawString($note,$small,[Drawing.Brushes]::Black,35,([single]$ny));[void]$svg.AppendLine("<text x='35' y='$($ny+22)' font-size='21'>$(Esc $note)</text>");[void]$cells.AppendLine("<mxCell id='note_$ni' value='$(Esc $note)' style='text;html=0;align=left;fontSize=21;fontColor=#000000;' vertex='1' parent='1'><mxGeometry x='35' y='$ny' width='$($m.width-70)' height='32' as='geometry'/></mxCell>");$ny+=32;$ni++}
    [void]$svg.AppendLine('</g></svg>')
    $drawio="<mxfile host='app.diagrams.net'><diagram name='$(Esc $m.title)' id='$($m.name)'><mxGraphModel page='1' pageWidth='$($m.width)' pageHeight='$($m.height)'><root>$cells</root></mxGraphModel></diagram></mxfile>"
    $base=Join-Path $PSScriptRoot $m.name;$utf8=[Text.UTF8Encoding]::new($false);[IO.File]::WriteAllText(($base+'.svg'),$svg.ToString(),$utf8);[IO.File]::WriteAllText(($base+'.drawio'),$drawio,$utf8);$bmp.Save(($base+'.png'),[Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose();$bmp.Dispose();$pen.Dispose();$dashed.Dispose();$font.Dispose();$small.Dispose();$title.Dispose();$fmt.Dispose()
    Write-Output "Generado: $($m.name) (drawio, SVG y PNG 2x)"
}
