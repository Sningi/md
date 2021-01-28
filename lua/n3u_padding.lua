local NAME = "Padding"
pad_protocol_v = Proto("Padding_N3", "Padding for n3")

-- Header fields

    -- uint32_t ng_u_teid;                                         
    -- uint32_t tac_v;                                 
    -- uint64_t msisdn_v;           
    -- uint64_t imei_v;     
    -- uint64_t  imsi_v;       
    -- uint64_t  cell_id;

    -- uint32_t  user_ip;  //? 

    -- uint16_t mcc;                            
    -- uint16_t  mnc;      
    -- uint8_t  rat_type;                            
    -- uint8_t resv1;                       
    -- char dnn[32];   
    -- unit8_t type;
    -- unit8_t recv_2;

    -- unit64_t src_ipv6_upper;   //?
    -- unit64_t src_ipv6_lower;   //?
    -- unit64_t dst_ipv6_upper;   //?          
    -- unit64_t dst_ipv6_lower;   //?                                      

ng_u_teid = ProtoField.uint32(NAME ..".gtpu_teid", "gtpu_teid", base.HEX)
tac_v = ProtoField.uint32(NAME ..".tac", "tac", base.HEX)
msisdn_v  = ProtoField.uint64(NAME .. ".msisdn", "MSISDN")
imei_v  = ProtoField.uint64(NAME .. ".imei", "IMEI")
imsi_v  = ProtoField.uint64(NAME .. ".imsi", "IMSI")
cell_id = ProtoField.uint64(NAME .. ".cell_id", "cell_id")
mcc_v = ProtoField.uint16(NAME .. ".mcc","mcc")
mnc = ProtoField.uint16(NAME .. ".mnc","mnc")
rat_type = ProtoField.uint8(NAME .. ".rat_type","rat_type")
resv1 = ProtoField.uint8(NAME .. ".resv1","resv1")
src_ip_ipv4 = ProtoField.ipv4(NAME .. ".src_ip","src_ip")
dst_ip_ipv4 = ProtoField.ipv4(NAME .. ".dst_ip","dst_ip")
dst_ip_ipv6 = ProtoField.ipv6(NAME ..".dst_ipv6","dst_ipv6")
src_ip_ipv6 = ProtoField.ipv6(NAME ..".src_ipv6","src_ipv6")


pad_protocol_v.fields = {ng_u_teid, msisdn_v, imei_v, imsi_v,tac_v,cell_id}

local function heuristic_checker_n3(buffer, pinfo, tree)
    -- guard for length
    length = buffer:len()
    if length < 128 then return false end

    local recv_teid = buffer(length-128+4,4):uint()
    recv_teid = 0
    if recv_teid == 0
    then
        pad_protocol_v.dissector(buffer, pinfo, tree)
        return true
    else return false end
end

function pad_protocol_v.dissector(buffer, pinfo, tree)
    length = buffer:len()
    offset = length-128

    pinfo.cols.protocol = pad_protocol_v.name

    local subtree = tree:add(pad_protocol_v, buffer(), "N3 Pad Protocol Data")
    -- Header
    subtree:add(ng_u_teid, buffer(offset,4))
    subtree:add(tac_v, buffer(offset+4,4))
    subtree:add(msisdn_v, buffer(offset+8,8))
    subtree:add(imei_v, buffer(offset+16,8))
    subtree:add(imsi_v, buffer(offset+24,8))
    subtree:add(cell_id, buffer(offset+32,8))
    -- subtree:add(src_ip_ipv4,buffer(offset+40,8))
    -- subtree:add(mcc_v, buffer(offset+56,2))
    -- subtree:add(mnc, buffer(offset+58,2))
    -- subtree:add(rat_type, buffer(offset+42,1))
    -- subtree:add(recv_1, buffer(offset+44,1))
    -- subtree:add(dnn_v,buffer(offset+45,28))
    -- subtree:add(type_v,buffer(offset+34,1))
end

pad_protocol_v:register_heuristic("eth.trailer", heuristic_checker_n3)
