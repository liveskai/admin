global function Titanfall
global function TitanfallCommand
global function TitanfallCMD

void function TitanfallCommand()
{
	#if SERVER
	AddClientCommandCallback("titanfall", TitanfallCMD);
	AddClientCommandCallback("tf", TitanfallCMD);
	#endif
}

bool function TitanfallCMD(entity player, array<string> args)
{
	#if SERVER
	array<entity> players = GetPlayerArray();
	hadGift_Admin = false;
	CheckAdmin(player);
	if (hadGift_Admin != true)
	{
		Kprint( player, "Admin permission not detected.");
		return true;
	}

	// if player only typed "gift"
	if (args.len() == 0)
	{
		Kprint( player, "Give a valid argument.");
		Kprint( player, "Example: titanfall/tf <playerID> <playerID2> <playerID3> ... / all");
		// print every single player's name and their id
		int i = 0;
		foreach (entity p in GetPlayerArray())
		{
			string playername = p.GetPlayerName();
			Kprint( player, "[" + i.tostring() + "] " + playername);
			i++
		}
		return true;
	}

	CMDsender = player
	switch (args[0])
	{
		case ("all"):
			foreach (entity p in GetPlayerArray())
			{
				if (p != null)
					Titanfall(p)
			}
		break;

		case ("imc"):
			foreach (entity p in GetPlayerArrayOfTeam( TEAM_IMC ))
			{
				if (p != null)
					Titanfall(p)
			}
		break;

		case ("militia"):
			foreach (entity p in GetPlayerArrayOfTeam( TEAM_MILITIA ))
			{
				if (p != null)
					Titanfall(p)
			}
		break;

		default:
            CheckPlayerName(args[0])
				foreach (entity p in successfulnames)
                    Titanfall(p)
		break;
	}
	if (args.len() > 1) {
		CMDsender = player
		array<string> playersname = args.slice(1);
		foreach (string playerId in playersname)
		{
            CheckPlayerName(playerId)
				foreach (entity p in successfulnames)
                    Titanfall(p)
		}
	}

	#endif
	return true;
}

void function Titanfall(entity player)
{
#if SERVER
	try {
		if (!player.IsTitan()) {
			if ( SpawnPoints_GetTitan().len() > 0 )
			{
				thread CreateTitanForPlayerAndHotdrop( player, GetTitanReplacementPoint( player, false ) )
			}
		}
	} catch(e)
	{
		Kprint( CMDsender, "Unable to drop " + player.GetPlayerName() + "'s titan. Could be already has a Titan lol.")
	}
#endif
}