foreach ($num in 1..6)
{
    $root_folder = '\OneDrive\Sync\Work\word\'+$num+'\'
    $folder_link = $env:USERPROFILE+$root_folder+'\test\'
    $final = foreach ($file in (Get-ChildItem $folder_link -Name))
    {
        $file_link = $env:USERPROFILE+$root_folder+'\test\'+$file
        $result = foreach ($content in Get-Content $file_link  -encoding utf8)
        {
            echo '<item>'
            if ($content -match('<div class="b".*?</div>'))
            {
                echo '<word>'($Matches[0] -replace('<.*?>'))'</word>'
            }
            if ($content -match('<div class="a1">.*?</div>'))
            {
                echo '<family>'
                $Matches[0] -replace('class="calibre[2-9]','>|start|<') -replace(':','|end|:') -replace('<span.*?>',"`n") -replace('<.*?>') -replace('/') -replace("`n","|ent|") -replace('(\|start\|){2,}','|start|')
                echo '</family>'

            }
            if ($content -match('<div class="i">.*?</div>'))
            {
                echo '<meaning>'($Matches[0] -replace('<.*?>'))'</meaning>'
            }
            if ($content -match('<div class="a">.*?</div>'))
            {
                echo '<description>'($Matches[0] -replace('<.*?>'))'</description>'
            }
            if ($content -match('<div class="n">.*?</div></div>'))
            {
                echo '<usage>'
                $a = ($Matches[0] -replace('</div>',"</div>`n"))
                foreach($b in $a)
                {
                    $b -replace('<div class="n">','|divide_ex|') -replace("</div>`n",'|/divide_ex|') -replace('<.*?>')
                }
                echo '</usage>'
            }
            echo '</item>'
        }
        echo $result
    }
    $out_path = $env:USERPROFILE+$root_folder+'test'+$num+'.txt'
    $final | Out-File $out_path
    echo 'The file test'($num -replace("`n"))'.txt has been written to disk'
}