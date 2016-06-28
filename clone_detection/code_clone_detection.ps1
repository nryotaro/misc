# path to cpd
$cpd="cpd.bat"
# oss
$app="app"
# svn remote repository
$remoteRepository = "https://remote/$app"
# the location of this script
$workDir = Split-Path $MyInvocation.MyCommand.Path

cd $workDir
# exports the application into the directory in which this script resides 
svn export $remoteRepository 

# removes auto-generated codes.
ls $app -r | where {$_.fullName -match "msg\\(foo|bar)$" } | rm -r

<# finds duplicated codes
   reference: http://pmd.github.io/pmd-5.4.2/usage/cpd-usage.html  #>
iex "$cpd --minimum-tokens 100 --encoding utf-8 --files .\$app\src" > duplicated_codes.txt
