enum EDirection
{
    Sent,
    Received
}

class CChat {
    CChat() 
    {
        return;
    }

    ~CChat() {
        return;
    }

    private CGameScriptChatManager@ GetChatManager() 
    {
        return GetApp().ChatManagerScript;
    }

    void SendChatMessageToLogin(string _message, string _name) 
    {
        auto catMgr = GetChatManager();
        auto contact = GetContactFromName(_name);
        catMgr.SendMessage(contact, _message);
    }

    void SendChatMessageToLoginDetailed(string _body, string _link, string _metadata, string _name) 
    {
        auto catMgr = GetChatManager();
        auto contact = GetContactFromName(_name);
        catMgr.SendMessage2(contact, _body, _link, _metadata);
    }

    private CGameScriptChatContact@ GetContactFromName(string _name) 
    {
        return GetApp().ChatManagerScript.GetContactFromLogin(_name);
    }

    private CGameScriptChatHistory@ GetChatHistoryFromName(string _name) 
    {
        auto catMgr = GetChatManager();
        return catMgr.History_Create_Contact(GetContactFromName(_name));
    }

    private void DeleteAllHistories()
    {
        auto catMgr = GetChatManager();
        catMgr.History_DestroyAll();
    }

    array<CMessage> GetChatMessagesByName(string _name) 
    {
        array<CMessage> messages;
        auto history = GetChatHistoryFromName(_name);
        for (uint i = 0; i < history.Entries.Length; i++) {
            auto entry = history.Entries[i];

            CMessage message;
            message.Direction = EDirection(entry.Direction);
            message.Body = entry.Messages[0].Body;
            message.Link = entry.Messages[0].Link;
            message.Metadata = entry.Messages[0].Metadata;

            messages.InsertLast(message);
        }
        DeleteAllHistories();
        return messages;
    }

    void SetPresence(int presencetype, string _presence) 
    {
        auto catMgr = GetChatManager();
        catMgr.PresenceSet(CGameScriptChatManager::EPresenceShow(presencetype), _presence);
    }
}

class CMessage
{
    string Body;
    string Link;
    string Metadata;
    EDirection Direction;

    string ToString()
    {
        return Body;
    }
}