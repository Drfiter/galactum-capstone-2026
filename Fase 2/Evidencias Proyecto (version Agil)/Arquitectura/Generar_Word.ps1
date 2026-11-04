# Genera el consolidado desde los Markdown y las mismas figuras publicadas.
# Windows PowerShell 5.1+, sin dependencias externas. No modifica el juego.
$ErrorActionPreference='Stop'
Add-Type -AssemblyName System.IO.Compression.FileSystem
$script:links=[Collections.Generic.List[object]]::new()
function X([string]$s){[Security.SecurityElement]::Escape($s)}
function Runs([string]$s){
    $s=$s.Replace('`','');$sb=[Text.StringBuilder]::new();$pos=0
    foreach($m in [regex]::Matches($s,'\[([^\]]+)\]\(([^)]+)\)')){
        if($m.Index -gt $pos){[void]$sb.Append("<w:r><w:t xml:space='preserve'>$(X $s.Substring($pos,$m.Index-$pos))</w:t></w:r>")}
        $id='link'+($script:links.Count+1);$script:links.Add(@{id=$id;target=$m.Groups[2].Value})
        [void]$sb.Append("<w:hyperlink r:id='$id'><w:r><w:rPr><w:color w:val='000000'/><w:u w:val='single'/></w:rPr><w:t>$(X $m.Groups[1].Value)</w:t></w:r></w:hyperlink>");$pos=$m.Index+$m.Length
    }
    if($pos -lt $s.Length){[void]$sb.Append("<w:r><w:t xml:space='preserve'>$(X $s.Substring($pos))</w:t></w:r>")};$sb.ToString()
}
function P([string]$s,[string]$style='Normal') {"<w:p><w:pPr><w:pStyle w:val='$style'/></w:pPr>$(Runs $s)</w:p>"}
function Tables([string]$name){
    $result=[Collections.Generic.List[object]]::new();$rows=[Collections.Generic.List[object]]::new()
    foreach($line in Get-Content -LiteralPath (Join-Path $PSScriptRoot $name) -Encoding UTF8){
        if($line.StartsWith('|')){if($line -notmatch '^\|[\s:|\-]+$'){$cells=@($line.Trim().Trim('|').Split('|') | ForEach-Object {$_.Trim()});$rows.Add($cells)}}
        elseif($rows.Count){$result.Add(@($rows.ToArray()));$rows=[Collections.Generic.List[object]]::new()}
    };if($rows.Count){$result.Add(@($rows.ToArray()))};return ,$result
}
function T($rows,$widths){
    $sb=[Text.StringBuilder]::new();[void]$sb.Append("<w:tbl><w:tblPr><w:tblW w:w='15000' w:type='dxa'/><w:tblLayout w:type='fixed'/><w:tblBorders><w:top w:val='single' w:sz='4'/><w:left w:val='single' w:sz='4'/><w:bottom w:val='single' w:sz='4'/><w:right w:val='single' w:sz='4'/><w:insideH w:val='single' w:sz='4'/><w:insideV w:val='single' w:sz='4'/></w:tblBorders><w:tblCellMar><w:top w:w='70' w:type='dxa'/><w:bottom w:w='70' w:type='dxa'/><w:left w:w='90' w:type='dxa'/><w:right w:w='90' w:type='dxa'/></w:tblCellMar></w:tblPr><w:tblGrid>")
    foreach($ww in $widths){[void]$sb.Append("<w:gridCol w:w='$ww'/>")};[void]$sb.Append('</w:tblGrid>')
    $ri=0;foreach($row in $rows){$rp='<w:cantSplit/>';if($ri -eq 0){$rp+='<w:tblHeader/>'};[void]$sb.Append("<w:tr><w:trPr>$rp</w:trPr>");$ci=0
        foreach($cell in $row){$plain=X (($cell -replace '\[([^\]]+)\]\([^)]+\)','$1').Replace([string][char]96,''));$bold='';if($ri -eq 0){$bold='<w:b/>'};[void]$sb.Append("<w:tc><w:tcPr><w:tcW w:w='$($widths[$ci])' w:type='dxa'/><w:vAlign w:val='center'/></w:tcPr><w:p><w:pPr><w:spacing w:after='20' w:line='240' w:lineRule='auto'/></w:pPr><w:r><w:rPr>$bold<w:sz w:val='20'/></w:rPr><w:t xml:space='preserve'>$plain</w:t></w:r></w:p></w:tc>");$ci++}
        [void]$sb.Append('</w:tr>');$ri++
    };[void]$sb.Append('</w:tbl>');$sb.ToString()
}
function Section([string]$name,[string]$heading){
    $lines=Get-Content -LiteralPath (Join-Path $PSScriptRoot $name) -Encoding UTF8;$start=-1;$sb=[Text.StringBuilder]::new()
    for($i=0;$i -lt $lines.Count;$i++){if($lines[$i] -eq $heading){$start=$i;break}}
    if($start -lt 0){throw "No se encontro seccion: $heading"}
    for($i=$start+1;$i -lt $lines.Count;$i++){$s=$lines[$i];if($s -match '^## '){break};if(!$s -or $s.StartsWith('|') -or $s.StartsWith('![')){continue};if($s.StartsWith('### ')){[void]$sb.Append((P $s.Substring(4) 'Heading2'))}else{[void]$sb.Append((P $s))}};$sb.ToString()
}
function Image([string]$id,[int]$w,[int]$h){
    $cx=8686800;$cy=[long]($cx*$h/$w)
    "<w:p><w:pPr><w:jc w:val='center'/><w:spacing w:after='0'/></w:pPr><w:r><w:drawing><wp:inline distT='0' distB='0' distL='0' distR='0'><wp:extent cx='$cx' cy='$cy'/><wp:docPr id='$($id.TrimStart('i'))' name='$id'/><a:graphic><a:graphicData uri='http://schemas.openxmlformats.org/drawingml/2006/picture'><pic:pic><pic:nvPicPr><pic:cNvPr id='0' name='$id'/><pic:cNvPicPr/></pic:nvPicPr><pic:blipFill><a:blip r:embed='$id'/><a:stretch><a:fillRect/></a:stretch></pic:blipFill><pic:spPr><a:xfrm><a:off x='0' y='0'/><a:ext cx='$cx' cy='$cy'/></a:xfrm><a:prstGeom prst='rect'><a:avLst/></a:prstGeom></pic:spPr></pic:pic></a:graphicData></a:graphic></wp:inline></w:drawing></w:r></w:p>"
}
$v=Tables 'Vista_Logica_Galactum.md';$c=Tables 'Diagrama_Componentes_Galactum.md';$d=Tables 'DIAGNOSTICO_Y_FUENTES.md';$docker=Tables 'CORRESPONDENCIA_DOCKER.md'
$pages=[Collections.Generic.List[string]]::new()
$pages.Add((P 'GALACTUM' 'Title')+(P 'Vista Lógica y Diagrama de Componentes' 'Title')+(P 'Proyecto APT · Ingeniería en Informática · Duoc UC · Equipo 3' 'Subtitle')+(P 'Fase 2 · MVP v0.12 · Godot 4.6.2 · 4 de noviembre de 2026')+(P 'Aporte documental: Juan Castro, con asistencia de Codex. Revisión del equipo pendiente.')+(P 'Propósito y alcance' 'Heading1')+(P 'Documentar la organización funcional y los módulos de Mundo y Combate. Se preservan los antecedentes M0–M2 y se describe el MVP integrado sin atribuir a Juan su programación ni las pruebas anteriores.')+(P 'La lógica se revisó en lectura en el objeto técnico 735902689558c59f5ff05ce80e6e14d83909c0e6. Docker y su adaptación web se respaldan en documentos y capturas; su configuración exacta sigue pendiente de cotejo.')+(P 'Contenido' 'Heading1')+(P '1. Vista Lógica: figura, responsabilidades, relaciones y flujos.')+(P '2. Componentes: figura, módulos, interfaces y dependencias.')+(P '3. Correspondencia con Docker y alcance de la evidencia.')+(P '4. Fuentes, límites y preparación de la exposición.'))
$pages.Add((P '1. Vista Lógica — diagrama' 'Heading1')+(Image 'i1' 1600 1000)+(P 'Vista conceptual. L1–L9 se explican en la tabla de relaciones. Fuente: elaboración documental basada en S5–S9.' 'Caption'))
$pages.Add((P '1.1 Responsabilidades funcionales' 'Heading1')+(Section 'Vista_Logica_Galactum.md' '## 1. Propósito y alcance')+(T $v[0] @(3200,8700,3100))+(P 'Persistencia es una responsabilidad del servidor. La minería se mantiene en flotas; no se introduce un subsistema independiente.'))
$pages.Add((P '1.2 Relaciones de la Vista Lógica' 'Heading1')+(T $v[1] @(750,4250,10000))+(P 'Las flechas describen uso funcional, no una secuencia temporal. Las notificaciones de la réplica actualizan la UI. Un cruce de líneas sin nodo no crea una relación adicional.'))
$pages.Add((P '1.3 Flujos, autoridad y sincronización' 'Heading1')+(Section 'Vista_Logica_Galactum.md' '## 4. Relaciones'))
$pages.Add((P '2. Diagrama de Componentes' 'Heading1')+(Image 'i2' 1800 1100)+(P 'Notación UML simplificada. Dependencias consumidor → proveedor; retornos por señales o mensajes. Fuentes S5–S9.' 'Caption'))
$pages.Add((P '2.1 Catálogo de componentes' 'Heading1')+(T $c[0] @(2300,3900,5300,3500))+(P 'Todos los nombres son referencias de implementación; no se reproduce su código. El guardado es un artefacto JSON y la persistencia está dentro de GameServer. Catalog se instancia en cada contexto que lo utiliza.'))
$pages.Add((P '2.2 Dependencias e interfaces' 'Heading1')+(T $c[1] @(750,4500,9750))+(P 'Catalog también es utilizado por cliente, flotas y servidor. Se omiten gráficamente dependencias auxiliares. Los módulos del mismo servidor no son microservicios.'))
$pages.Add((P '2.3 Contrato y alcance del modelo' 'Heading1')+(Section 'Diagrama_Componentes_Galactum.md' '## 5. Interfaces y despliegue')+(Section 'Diagrama_Componentes_Galactum.md' '## 6. Fuentes y pendientes')+(P 'Arranque y modo embebido' 'Heading2')+(P 'app/boot.gd selecciona título o servidor dedicado y compone GameServer con gateway. El cliente nativo conserva LocalLink y servidor embebido. El diagrama principal representa el modo dedicado utilizado por la evidencia web; no afirma que el servidor embebido corra en Nginx.'))
$pages.Add((P '3. Correspondencia con Docker' 'Heading1')+(T $docker[0] @(2200,10500,2300))+(Section 'CORRESPONDENCIA_DOCKER.md' '## Comunicación y autoridad')+(Section 'CORRESPONDENCIA_DOCKER.md' '## Alcance de la evidencia Docker'))
$pages.Add((P '4. Fuentes utilizadas' 'Heading1')+(T $d[0] @(650,8300,6050))+(P 'Las rutas del catálogo corresponden a archivos del repositorio académico; S9 identifica la lectura autorizada del repositorio técnico. Los documentos Markdown conservan los enlaces completos.'))
$pages.Add((P '4.1 Límites y revisión de la entrega' 'Heading1')+(Section 'DIAGNOSTICO_Y_FUENTES.md' '## Configuración aún no disponible')+(Section 'DIAGNOSTICO_Y_FUENTES.md' '## Nivel de evidencia')+(P 'Preparación de Juan' 'Heading2')+(P 'Explicar la diferencia entre función, módulo y despliegue; seguir los recorridos de minería y caza; justificar cada flecha por su ID; distinguir catálogo y guardado; explicar que Nginx distribuye archivos y el navegador ejecuta el cliente. La comprensión y aprobación personal deben confirmarse con Juan, no se presuponen.')+(P 'Fuentes editables' 'Heading2')+(P 'Los modelos JSON y el generador producen las mismas figuras drawio, SVG y PNG. El Word utiliza exactamente esos PNG. Véase [guía de revisión](REVISION_Y_EXPOSICION.md) y [diagnóstico](DIAGNOSTICO_Y_FUENTES.md).'))
function Sect([int]$number){"<w:sectPr><w:footerReference w:type='default' r:id='footer$number'/><w:type w:val='nextPage'/><w:pgSz w:w='16838' w:h='11906' w:orient='landscape'/><w:pgMar w:top='650' w:right='850' w:bottom='650' w:left='850' w:header='250' w:footer='300'/></w:sectPr>"}
$body='';for($i=0;$i -lt $pages.Count;$i++){$body+=$pages[$i];if($i -lt $pages.Count-1){$body+="<w:p><w:pPr>$(Sect ($i+1))</w:pPr></w:p>"}};$sect=Sect $pages.Count
$doc="<?xml version='1.0' encoding='UTF-8'?><w:document xmlns:w='http://schemas.openxmlformats.org/wordprocessingml/2006/main' xmlns:r='http://schemas.openxmlformats.org/officeDocument/2006/relationships' xmlns:wp='http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing' xmlns:a='http://schemas.openxmlformats.org/drawingml/2006/main' xmlns:pic='http://schemas.openxmlformats.org/drawingml/2006/picture'><w:body>$body$sect</w:body></w:document>"
$styles="<?xml version='1.0' encoding='UTF-8'?><w:styles xmlns:w='http://schemas.openxmlformats.org/wordprocessingml/2006/main'><w:docDefaults><w:rPrDefault><w:rPr><w:rFonts w:ascii='Arial' w:hAnsi='Arial'/><w:b w:val='0'/><w:bCs w:val='0'/><w:sz w:val='22'/><w:color w:val='000000'/><w:lang w:val='es-CL'/></w:rPr></w:rPrDefault><w:pPrDefault><w:pPr><w:spacing w:after='100' w:line='260' w:lineRule='auto'/></w:pPr></w:pPrDefault></w:docDefaults><w:style w:type='paragraph' w:default='1' w:styleId='Normal'><w:name w:val='Normal'/><w:rPr><w:b w:val='0'/><w:bCs w:val='0'/></w:rPr></w:style>"
foreach($s in @(@('Title',36),@('Subtitle',26),@('Heading1',28),@('Heading2',24),@('Caption',18))){$styles+="<w:style w:type='paragraph' w:styleId='$($s[0])'><w:name w:val='$($s[0])'/><w:basedOn w:val='Normal'/><w:pPr><w:keepNext/><w:spacing w:before='100' w:after='120'/></w:pPr><w:rPr><w:b/><w:sz w:val='$($s[1])'/><w:color w:val='000000'/></w:rPr></w:style>"};$styles+='</w:styles>'
$rels="<Relationships xmlns='http://schemas.openxmlformats.org/package/2006/relationships'><Relationship Id='styles' Type='http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles' Target='styles.xml'/>"
for($i=1;$i -le $pages.Count;$i++){$rels+="<Relationship Id='footer$i' Type='http://schemas.openxmlformats.org/officeDocument/2006/relationships/footer' Target='footer$i.xml'/>"}
foreach($i in 1..2){$rels+="<Relationship Id='i$i' Type='http://schemas.openxmlformats.org/officeDocument/2006/relationships/image' Target='media/diagram$i.png'/>"};foreach($l in $script:links){$rels+="<Relationship Id='$($l.id)' Type='http://schemas.openxmlformats.org/officeDocument/2006/relationships/hyperlink' Target='$(X $l.target)' TargetMode='External'/>"};$rels+='</Relationships>'
$types="<Types xmlns='http://schemas.openxmlformats.org/package/2006/content-types'><Default Extension='rels' ContentType='application/vnd.openxmlformats-package.relationships+xml'/><Default Extension='xml' ContentType='application/xml'/><Default Extension='png' ContentType='image/png'/><Override PartName='/word/document.xml' ContentType='application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml'/><Override PartName='/word/styles.xml' ContentType='application/vnd.openxmlformats-officedocument.wordprocessingml.styles+xml'/>"
for($i=1;$i -le $pages.Count;$i++){$types+="<Override PartName='/word/footer$i.xml' ContentType='application/vnd.openxmlformats-officedocument.wordprocessingml.footer+xml'/>"};$types+='</Types>'
$out=Join-Path $PSScriptRoot 'Arquitectura_Galactum_Vista_Logica_y_Componentes.docx';if(Test-Path -LiteralPath $out){Remove-Item -LiteralPath $out}
$zip=[IO.Compression.ZipFile]::Open($out,'Create')
try{
    $entries=@{'[Content_Types].xml'=$types;'_rels/.rels'="<Relationships xmlns='http://schemas.openxmlformats.org/package/2006/relationships'><Relationship Id='doc' Type='http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument' Target='word/document.xml'/></Relationships>";'word/document.xml'=$doc;'word/styles.xml'=$styles;'word/_rels/document.xml.rels'=$rels;'word/footer1.xml'="<w:ftr xmlns:w='http://schemas.openxmlformats.org/wordprocessingml/2006/main'><w:p><w:pPr><w:jc w:val='right'/></w:pPr><w:r><w:t>Galactum · Fase 2 · </w:t></w:r><w:fldSimple w:instr='PAGE'/></w:p></w:ftr>"}
    for($i=1;$i -le $pages.Count;$i++){$entries["word/footer$i.xml"]="<w:ftr xmlns:w='http://schemas.openxmlformats.org/wordprocessingml/2006/main'><w:p><w:pPr><w:jc w:val='right'/></w:pPr><w:r><w:t xml:space='preserve'>Galactum · Fase 2 · Página </w:t></w:r><w:fldSimple w:instr='PAGE'><w:r><w:t>$i</w:t></w:r></w:fldSimple></w:p></w:ftr>"}
    foreach($key in $entries.Keys){$e=$zip.CreateEntry($key);$wr=[IO.StreamWriter]::new($e.Open(),[Text.UTF8Encoding]::new($false));$wr.Write($entries[$key]);$wr.Dispose()}
    $names=@('Vista_Logica_Galactum','Diagrama_Componentes_Galactum');for($i=0;$i -lt 2;$i++){[void][IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip,(Join-Path $PSScriptRoot ('Diagramas\'+$names[$i]+'.png')),('word/media/diagram'+($i+1)+'.png'))}
}finally{$zip.Dispose()}
Write-Output "Word generado: $out ($($pages.Count) paginas planificadas)"
