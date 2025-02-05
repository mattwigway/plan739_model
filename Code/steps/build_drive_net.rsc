/*
Build the road network (for driving)
*/
macro "Build Drive Network" (Args)
    Data:
        In({Args.[Road Line Layer]})
        In({Args.[Output Folder]})
        In({Args.[Drive Filter]})

    Body:

    AppendToLogFile(0, "Build Drive Network")

    // build the network
    // Modified from tRMG2 code
    o = CreateObject("Network.Create")
    o.LayerDB = Args.[Road Line Layer]
    o.Filter = Args.[Drive Filter]  
    o.LengthField = "Length"
    
    o.AddLinkField({Name: "TimeAM", Field: {"ABTimeAM", "BATimeAM"}, IsTimeField: true})
    o.AddLinkField({Name: "TimeMD", Field: {"ABTimeMD", "BATimeMD"}, IsTimeField: true})
    o.AddLinkField({Name: "TimePM", Field: {"ABTimePM", "BATimePM"}, IsTimeField: true})
    o.AddLinkField({Name: "TimeNT", Field: {"ABTimeNT", "BATimeNT"}, IsTimeField: true})
    o.AddLinkField({Name: "BusTimeAM", Field: {"ABBusTimeAM", "BABusTimeAM"}, IsTimeField: true})
    o.AddLinkField({Name: "BusTimeMD", Field: {"ABBusTimeMD", "BABusTimeMD"}, IsTimeField: true})
    o.AddLinkField({Name: "BusTimePM", Field: {"ABBusTimePM", "BABusTimePM"}, IsTimeField: true})
    o.AddLinkField({Name: "BusTimeNT", Field: {"ABBusTimeNT", "BABusTimeNT"}, IsTimeField: true})

    o.AddNodeField({Name: "Centroid", Field: "Centroid"})

    o.OutNetworkName = Args.[Output Folder] + "auto.net"
    o.Run()

    AppendToLogFile(1, "Network built")


    AppendToLogFile(1, "Creating map file")
    RunMacro("Create Road Network Map", Args.[Road Line Layer], "Drive", Args.[Drive Filter],
    Args.[Output Folder] + "auto.net", Args.[Output Folder] + "auto.map")

    return(true)
endmacro