
# Planejamento

#
# 1 - Pegar uma piada do chuck norris
# 2 - Pegar uma piada para cada categoria
# 3 - Salvar essas piadas em um arquivo TXT contendo:
#     - A piada e a sua categoria
#     - Salvar em uma pasta chamada chuck_jokes
#     - Onde as piadas vão ser salvas em um txt no formato:
#            - 2024-02-23_010324.txt


#$url = "https://api.chucknorris.io/jokes/random"
#
#
#$r = Invoke-WebRequest  -uri $url 
#
#$r_result = $($r.Content | Out-String | ConvertFrom-Json).value
#
#echo $r_result


#========#
# Fazendo o caminho da pasta, eu poderia usar apenas .\chuck_jokes, funcionaria.
$pasta = [string]$(pwd) + "\chuck_jokes"

# Testando o caminho
if ( -not (Test-Path $pasta ))
{ # -Usei not para não ter que criar um else
 
    echo "Criando a pasta..."
    mkdir $pasta
}




$url_base = "https://api.chucknorris.io/jokes"

$url_categories = $url_base + "/categories"

$url_joke = $url_base + "/random?category="

$r = Invoke-WebRequest -Uri $url_categories -UseBasicParsing

$joke_categories_list = $r.Content | Out-String | ConvertFrom-Json


foreach ($jokes in $joke_categories_list)
{   
    # Criando o link correto
    $url = $url_joke + $jokes

    # Pedindo para entrar no site
    $r = Invoke-WebRequest -uri $url -UseBasicParsing

    # Arrumando as informações para formato hashtable/dicionário
    $r_result = $r.Content | Out-String | ConvertFrom-Json

    # Criando o caminho de cada categoria da piada
    $joke_current_path = $pasta + "\" + $r_result.categories 
    
    # Checando se existe a pasta de cada categoria da piada
    if ( -not (Test-Path $joke_current_path))
    {   
        # Senão existe, eu vou criar agora a pasta
        mkdir $joke_current_path
    }

    $joke_current_path = $joke_current_path + "\" + "$( $r_result.categories).txt"
    
    Add-Content -Path $joke_current_path -Value "$($r_result.value)"
    
    # Só exibindo no terminal
    echo "$($r_result.categories + "=" + $r_result.value)"

}

#$x = Get-Date -format "yyyy-MM-dd_HH:mm:ss"



























