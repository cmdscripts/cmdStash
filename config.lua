Config = {
    {
        Point = vector3(189.4335, -845.4243, 31.0613),
        NameJob = "police", 
        LabelJob = "Police",
        Society = "society_police",
        GradeJob = {"boss", "lieutenant"}
    },
    {
        Point = vector3(193.4321, -848.0484, 30.9120),
        NameJob = "ambulance", 
        LabelJob = "Ambulance",
        Society = "society_ambulance",
        GradeJob = {"boss"}
    },
--[[     {
        Point = vector3(193.4321, -848.0484, 30.9120),
        NameJob = "ambulance", 
        LabelJob = "Ambulance",
        Society = "society_ambulance",
        GradeJob = {"boss"}
    }, ]]
}

Translation = {
    ShowHelpNotification    = "~INPUT_CONTEXT~ Open the stash",
    Banner                  = "Stash",
    SubTitle                = "Stash Menu",
    JobLabel                = "Job: %s",
    DepositObjects          = "Deposit Objects",
    WithdrawObjects         = "Withdraw Objects",
    DepositNotify           = "You deposit: ",
    WithdrawNotify          = "You withdraw: ",
    Input                   = "How much?"
}

Config.Marker = function(Marker)
    DrawMarker(1, Marker.x, Marker.y, Marker.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 200, false, false, 2, nil, nil, false)
end