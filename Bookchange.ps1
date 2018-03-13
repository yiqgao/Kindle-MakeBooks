$web = $env:USERPROFILE+'\OneDrive\Sync\Work\Scripts\wordbook\part06.txt' 
$temp = Get-Content $web 
$b =0 
$book = foreach ($item in $temp -match '<p class="calibre_4"><span class="bold">.*?</dddd>')
{
    $b++ 
    $d = '<p id = "ch3-'+$b+'" class = "word_item">'+'<span class="word">'
    $sub_item = $item -replace ('<p class="calibre_4"><span class="bold">',$d) -replace ('</p> ','</h2>') -replace ('</span><span class="bold"><span class="calibre_2">','<span class="yinbiao">')
    $sub_item -replace ('</span></span><span class="bold">','</span>') -replace ('</dddd>','')
}
$book | Out-File 'C:\Users\v-yiqga\OneDrive\Sync\Work\Scripts\result_book\part06.txt'