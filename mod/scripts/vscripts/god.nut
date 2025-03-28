global function GodCommand
global function GodCMD
void function GodCommand()
{
    AddClientCommandCallback("god", GodCMD)
	AddClientCommandCallback("cgod", ClearGodCMD)
}
bool function GodCMD(entity player, array < string > args) 
{
	hadGift_Admin = false
	CheckAdmin(player)
	if (!hadGift_Admin) 
	{
		Kprint( player, "你没有管理员权限")
		return true
	}

	player.SetInvulnerable()
	Kprint(player, "开启无敌")
	return true
}
bool function ClearGodCMD(entity player, array < string > args) 
{
	player.ClearInvulnerable()
	Kprint(player, "取消无敌")
	return true
}