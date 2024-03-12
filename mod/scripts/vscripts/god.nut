global function GodCommand
global function GodCMD
void function GodCommand()
{
    #if SERVER
    AddClientCommandCallback("god", GodCMD)
	AddClientCommandCallback("cgod", ClearGodCMD)
	AddClientCommandCallback("killme", KillMe)
    #endif
}
bool function GodCMD(entity player, array < string > args) 
{
	#if SERVER
	hadGift_Admin = false
	CheckAdmin(player)
	if (hadGift_Admin != true) 
	{
		Kprint( player, "你没有管理员权限")
		return true
	}

	player.SetInvulnerable()
	Kprint(player, "你无敌了")
	#endif
	return true
}
bool function ClearGodCMD(entity player, array < string > args) 
{
	#if SERVER
	player.ClearInvulnerable()
	Kprint(player, "取消无敌")
	#endif
	return true
}
bool function KillMe(entity player, array < string > args) 
{
	#if SERVER
	if ( IsAlive( player ) )
	{
		player.Die()
		Kprint(player, "自杀")
	}
	#endif
	return true
}