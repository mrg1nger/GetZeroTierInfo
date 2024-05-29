$bearer_token = "Bearer <token here>"
$network_id = "<networkid here>"
while($true){
CLEAR
$network_members = Invoke-RestMethod -Headers @{Authorization = $bearer_token} -Uri "https://api.zerotier.com/api/v1/network/$network_id/member" -Method GET -ContentType 'application/json'
foreach($member in $network_members){
	$online_check = $member.clock - $member.lastSeen
	if ($online_check -lt 100000) {
		$is_online = "Online"
	} else {
		$is_online = "*OFFLINE*"
	}
	Write-Host $member.name "-" $member.config.ipAssignments "- Authorized:" $member.config.authorized "- Time Offline:" $online_check "-" $is_online
}
Start-sleep -Seconds "900"
CLEAR
}