if (!(Test-Path "C:\Kustutatud.txt")){
    New-Item -Path "C:\Kustutatud.txt" 
}
#$num = (Get-ADGroup users -Properties *).Member.Count
$disabled = @(Search-ADAccount -AccountDisabled -UsersOnly | Select-Object SamAccountName)
#Get-ADUser -filter {(Enabled = $false)}
#echo $disabled.Length
for (($i=0);($i -lt $disabled.Length);($i++)){
    #echo $i
    $longname = ([string]$disabled[$i])
    $length = $longname.Length - 18
    $name = $longname.Substring(17, $length)
    $status = (Get-ADUser -Identity $name -Properties Description | Select-Object -ExpandProperty Description).tolower()

    #echo $status

    if($status -eq "lahkunud"){
        $date = get-date
        $fullname = (Get-ADUser -Identity $name -Properties DisplayName | Select-Object -ExpandProperty DisplayName)
    
        $msg = ([string]$date+" "+$fullname)
        Add-Content C:\Kustutatud.txt $msg

        Remove-ADUser -Identity $name -Confirm:$false
    }
}