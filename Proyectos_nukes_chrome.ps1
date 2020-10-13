#Codigos nucleares Powershell by soyYosoyYo 
$browser = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$user = $env:USERPROFILE
$fichero = $user + "\Desktop\ricura.txt"
$ficheroH = $user + "\Desktop\ricura.txt.history"
$nhentai = " nhentai.net/g/"
$hitomila = " hitomi.la/galleries/"
$html = ".html"
$search = "https://www.google.com/search?&q="

function EsNumerico($valor) {
    # Esta Funcion probara si el valor cadena de texto es un numero
    # Parametros
    #   $valor   - Cadena a probar
          return ($($valor.Trim()) -match "^[-]?[0-9.]+$")
}

#Quitar los espacios al principio/final de las lineas, lineas duplicadas y en blanco.
$contenido = Get-Content $fichero | Where-Object {$_ -ne ""}|ForEach-Object {$_.Trim()}| Sort-Object -Unique
Write-Output $contenido| Add-Content $ficheroH
#esto es inecesario se puede quitar
Write-Output $contenido| Set-Content $fichero
#acumulador
$conta = 0
#bucle
Write-Output $contenido | ForEach-Object { 
    # Si es un numero
    if ( EsNumerico($_)) {
        if (($_).length -gt 6) {

            & $browser "$hitomila$_$html" 
        }else {        
            & $browser "$nhentai$_"
        }             
    }else {
        & $browser "$search$_ hentai"
    }
    #aumentamos acumulador
    $conta = $conta + 1
    #si el acumulador es superior a 4 
    if ($conta -gt 4){
        $conta = 0#reiniciamos el contador a 0 y 
        Start-Sleep -s 5 #esperamos 5 sec
    }
}