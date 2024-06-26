const wstring EMPTY_STRING = "";

class CActivity
{
    EActivity GetCurrentActivity()
    {
        if (IsInMenuTitlepack())
            return EActivity::InMenuTitlepack;
        if (IsInServer())
            return EActivity::InServer;
        if (IsInRace())
            return EActivity::InRace;
        if (IsInEditor())
            return EActivity::InEditor;

        return EActivity::NotDoingAnything;
    }

    bool IsInServer()
    {
        auto app = cast<CTrackMania>(GetApp());
        auto network = cast<CTrackManiaNetwork>(app.Network);
        auto serverInfo = cast<CGameCtnNetServerInfo>(network.ServerInfo);

        return serverInfo !is null && serverInfo.ServerLogin != "";
    }

    bool IsInEditor()
    {
        auto app = cast<CTrackMania>(GetApp());
        return cast<CGameCtnEditorFree>(app.Editor) !is null;
    }

    bool IsInRace()
    {
        auto app = cast<CTrackMania>(GetApp());
        return app.RootMap !is null and app.Editor is null;
    }

    bool IsInMenuTitlepack()
    {
        auto app = cast<CGameManiaPlanet>(GetApp());
        if (app.ActiveMenus.Length == 0) return false;
        return app.ActiveMenus[0].CurrentFrame.IdName != "FrameManiaPlanetMain";
    }

    wstring GetLoadedTitlepackName()
    {
        return (cast<CGameManiaPlanet>(GetApp()).LoadedManiaTitle is null) ? EMPTY_STRING : (cast<CGameManiaPlanet>(GetApp()).LoadedManiaTitle.Name);
    }

    wstring GetServerName()
    {
        auto app = cast<CTrackMania>(GetApp());
        auto network = cast<CTrackManiaNetwork>(app.Network);
        auto serverInfo = cast<CGameCtnNetServerInfo>(network.ServerInfo);

        if (serverInfo is null) return "";

        return serverInfo.ServerName;
    }

    wstring GetMapName()
    {
        auto app = cast<CTrackMania>(GetApp());
        if (app.RootMap is null) return "";
        return app.RootMap.MapName;
    }
}