wstring presence = "";
wstring prevPresence = "";
int presencetype = 0;

enum EActivity
{
    NotDoingAnything,
    InRace,
    InServer,
    InMenuTitlepack,
    InEditor
}

CChat chatMgr;
CActivity activityMgr;

void Main() {  }

void Render()
{
    EActivity activity = activityMgr.GetCurrentActivity();
    wstring titlepack = activityMgr.GetLoadedTitlepackName();
    wstring server = activityMgr.GetServerName();
    wstring map = activityMgr.GetMapName();
    
    if (activity == EActivity::InServer)
    {
        presence = "In $<" + server + "$> | $<" + titlepack + "$>";
        presencetype = 0;
    }
    if (activity == EActivity::InRace)
    {
        presence = "Playing Solo: $<" + map + "$> | $<" + titlepack + "$>";
        presencetype = 0;
    }
    if (activity == EActivity::InMenuTitlepack)
    {
        presence = "In Titlepack Menu: $<" + titlepack + "$>";
        presencetype = 0;
    }
    if (activity == EActivity::InEditor)
    {
        presence = "In Editor: $<" + map + "$> | $<" + titlepack + "$>";
        presencetype = 0;
    }
    if (activity == EActivity::NotDoingAnything)
    {
        presence = "";
        presencetype = 0;
    }

    if (tostring(prevPresence) != tostring(presence))
    {
        chatMgr.SetPresence(presencetype, presence);
    }

    prevPresence = presence;
}