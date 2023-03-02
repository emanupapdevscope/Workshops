# Definir a chave de API
$apiKey = "2c2b8d18f05a4305a0d56f0a7bdc647a"

# Definir a URL base da API
$apiUrlBase = "https://api.football-data.org/v4"

# Definir a competição que você deseja obter as informações
#$competitionId = "2021" # Premier League

# Definir a data para a qual você deseja obter as informações
$date = Get-Date

$nextDate = $date.AddDays(1)

# Converter a data para o formato da API
$dateString = $date.ToString("yyyy-MM-dd")
$dateString2=$nextdate.ToString("yyyy-MM-dd")

# Criar a URL completa da API
#$url = "$apiUrlBase/competitions/$competitionId/matches?dateFrom=$dateString&dateTo=$dateString"
$url = "$apiUrlBase/matches?dateFrom=$dateString&dateTo=$dateString"

#$url2 = "$apiUrlBase/competitions/$competitionId/matches?dateFrom=$dateString2&dateTo=$dateString2"
$url2 = "$apiUrlBase/matches?dateFrom=$dateString2&dateTo=$dateString2"


# Fazer a requisição para a API
$response = Invoke-RestMethod -Uri $url -Headers @{ "X-Auth-Token" = $apiKey }
$response2 = Invoke-RestMethod -Uri $url2 -Headers @{ "X-Auth-Token" = $apiKey }

# Verificar se há jogos agendados para a data especificada
if ($response.count -eq 0) {
    Write-Host "Não há jogos agendados para hoje"
} else {
    # Exibir os jogos agendados
    Write-Host "Jogos para Hoje"
    foreach ($match in $response.matches) {
        $homeTeam = $match.homeTeam.name
        $awayTeam = $match.awayTeam.name
        $kickoffTime = [DateTime]::Parse($match.utcDate)
        $kickoffTimeString = $kickoffTime.ToString("HH:mm")
        Write-Host "$homeTeam x $awayTeam - $kickoffTimeString"
    }

}

if ($response2.count -eq 0) {
    Write-Host "Não há jogos agendados para amanha"
} else {
    # Exibir os jogos agendados
    Write-Host "Jogos para Amanha"
    foreach ($match in $response2.matches) {
        $homeTeam = $match.homeTeam.name
        $awayTeam = $match.awayTeam.name
        $kickoffTime = [DateTime]::Parse($match.utcDate)
        $kickoffTimeString = $kickoffTime.ToString("HH:mm")
        Write-Host "$homeTeam x $awayTeam - $kickoffTimeString"
    }

}
