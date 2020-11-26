local NAME = "ng_cdr"

ng_cdr_Protocol = Proto("ng_cdr", "CDR for N1N2")

-- Header fields

header_len = ProtoField.uint16(NAME ..".header_len", "header_len", base.DEC)
msg_type = ProtoField.uint16(NAME ..".msg_type", "msg_type", base.DEC)
seq_id = ProtoField.uint16(NAME ..".seq_id", "seq_id", base.DEC)
reserved = ProtoField.uint16(NAME ..".reserved", "reserved", base.DEC)
frag_mf_offset = ProtoField.uint32(NAME ..".frag_mf_offset", "frag_mf_offset", base.HEX)

total_len = ProtoField.uint16(NAME ..".total_len", "total_len", base.DEC)
table_id = ProtoField.uint16(NAME ..".table_id", "table_id", base.DEC)
service_type = ProtoField.uint16(NAME ..".service_type", "service_type", base.DEC)
policy_id = ProtoField.uint16(NAME ..".policy_id", "policy_id", base.DEC)

start_time  = ProtoField.uint64(NAME .. ".start_time", "start_time",base.DEC)
cdr_id  = ProtoField.uint64(NAME .. ".cdr_id", "cdr_id")
device_id = ProtoField.uint8(NAME ..".device_id", "device_id", base.DEC)
filter_flag = ProtoField.uint8(NAME ..".filter_flag", "filter_flag", base.DEC)
data_type = ProtoField.uint8(NAME ..".data_type", "data_type", base.DEC)
cpu_clock_mul = ProtoField.uint8(NAME ..".cpu_clock_mul", "cpu_clock_mul", base.DEC)
bcd_flag = ProtoField.uint8(NAME ..".bcd_flag", "bcd_flag", base.DEC)
reserved_1 = ProtoField.uint8(NAME ..".reserved_1", "reserved_1", base.DEC)
reserved_2 = ProtoField.uint8(NAME ..".reserved_2", "reserved_2", base.DEC)
reserved_3 = ProtoField.uint8(NAME ..".reserved_3", "reserved_3", base.DEC)
-- header

-- common info
amf_ue_ngap_id  = ProtoField.uint64(NAME .. ".amf_ue_ngap_id", "amf_ue_ngap_id",base.DEC)
ran_ue_ngap_id  = ProtoField.uint32(NAME .. ".ran_ue_ngap_id", "ran_ue_ngap_id",base.DEC)
amf_region_id = ProtoField.uint8(NAME ..".amf_region_id", "amf_region_id", base.DEC)
amf_set_id = ProtoField.uint16(NAME ..".amf_set_id", "amf_set_id", base.DEC)
amf_pointer = ProtoField.uint8(NAME ..".amf_pointer", "amf_pointer", base.DEC)
fiveg_tmsi  = ProtoField.uint32(NAME .. ".fiveg_tmsi", "fiveg_tmsi",base.DEC)

    -- ip_addr_t   amf_ip_addr; 
    -- uint16_t    amf_port;
    -- ip_addr_t   gnb_ip_addr;
    -- uint16_t    gnb_port;
    -- ip_addr_t   upf_gtp_ipv6;
    -- uint32_t    upf_gtp_ipv4;
    -- uint32_t    upf_gtp_teid;
    -- ip_addr_t   gnb_gtp_ipv6;
    -- uint32_t    gnb_gtp_ipv4;
    -- uint32_t    gnb_gtp_teid;
    -- ip_addr_t   additional_upf_gtp_ipv6;
    -- uint32_t    additional_upf_gtp_ipv4;
    -- uint32_t    additional_upf_gtp_teid;
    -- ip_addr_t   additional_gnb_gtp_ipv6;
    -- uint32_t    additional_gnb_gtp_ipv4;
    -- uint32_t    additional_gnb_gtp_teid;

    -- ip_addr_t   pdu_address_v6;
    -- uint32_t    pdu_address_v4;
    -- uint8_t     location_type;
    -- uint16_t    mcc;
    -- uint16_t    mnc;
    -- uint32_t    tac;
    -- uint64_t    ci;
    -- uint8_t     cipher_alg_id;
    -- uint8_t     imsi[16];//IMSI OR NAI
    -- uint8_t     imei[18];//IMEI OR IMEISV
    -- uint8_t     msisdn[24];//MSISDN
    -- uint8_t     suci[24];//
    -- uint64_t    start_time;
    -- uint8_t     dnn[32];  
imei  = ProtoField.string(NAME .. ".imei", "IMEI")
imsi  = ProtoField.string(NAME .. ".imsi", "IMSI")
msisdn  = ProtoField.string(NAME .. ".msisdn", "MSISDN")
dnn  = ProtoField.string(NAME .. ".dnn", "dnn")
-- small cdr
CDR= "cdr"
delay_time  = ProtoField.uint64(CDR .. ".delay_time", "delay_time")
-- uint8_t     cause;
-- uint8_t     cdr_type;
-- uint8_t     msg_type;
-- uint8_t     cdr_result;
-- uint8_t     direction;
type  = ProtoField.uint8(CDR .. ".type", "type", base.HEX)
direction  = ProtoField.uint8(CDR .. ".direction", "direction", base.DEC)


ng_cdr_Protocol.fields = {
    header_len,msg_type,seq_id,reserved,frag_mf_offset,total_len,table_id,
    service_type,policy_id,start_time,cdr_id,device_id,data_type,cpu_clock_mul,
    bcd_flag,reserved_1,reserved_2,reserved_3, filter_flag,     --cdr header
    -- common info
    imei,imsi,msisdn,dnn,
    -- small info
    delay_time,type,direction
}

local function cdr_checker(buffer, pinfo, tree)
    -- guard for length
    -- length = buffer:len()
    -- if length ~= 56 then return false end

    local header_len = buffer(0,2):uint16()

    if header_len == 44
    then
        ng_cdr_Protocol.dissector(buffer, pinfo, tree)
        return true
    else return false end
end

function get_cdr_description(cdrid)
    local cdr_desc = "Unknown CDR"
    if cdrid == 0x41 then cdr_desc = "REG"
    elseif cdrid == 0x45 then cdr_desc = "DEG-UE-ORI"
    elseif cdrid == 0x47 then cdr_desc = "DEG-UE-TER"
    elseif cdrid == 0x4c then cdr_desc = "SERVICE"
    elseif cdrid == 0x54 then cdr_desc = "CONF_UP"
    elseif cdrid == 0x56 then cdr_desc = "AUTH"
    elseif cdrid == 0x5b then cdr_desc = "IDE"
    elseif cdrid == 0x5d then cdr_desc = "SEC_MOD"
    elseif cdrid == 0xc1 then cdr_desc = "SM_EST"
    elseif cdrid == 0xc9 then cdr_desc = "SM_MOD"
    elseif cdrid == 0xd1 then cdr_desc = "SM_RELEASE"
    elseif cdrid == 0x01 then cdr_desc = "HO_OUT"
    elseif cdrid == 0x02 then cdr_desc = "HO_IN"
    elseif cdrid == 0xff then cdr_desc = "UE_CONTEXT_RELEASE" end
    
    return cdr_desc
end

function ng_cdr_Protocol.dissector(buffer, pinfo, tree)

    pinfo.cols.protocol = ng_cdr_Protocol.name

    local subtree = tree:add(ng_cdr_Protocol, buffer(), "NG CDR Data")
    local headerSubtree = subtree:add(ng_cdr_Protocol, buffer(0,44),    "Header         len:44")
    local commonSubtree = subtree:add(ng_cdr_Protocol, buffer(44, 367), "COMMON CDR     len:367")
    local len = buffer:len()-44-367
    local cdrSubtree = subtree:add(ng_cdr_Protocol, buffer(44+367,len), "SMALL CDR      len:" .. len .. "")

    -- CDR Header
    local offset = 0
    headerSubtree:add(header_len, buffer(offset,2)):append_text(" (len must 44)")
    offset = offset + 2
    -- msg_type = ProtoField.uint16(NAME ..".msg_type", "msg_type", base.DEC)
    offset = offset + 2
    -- seq_id = ProtoField.uint16(NAME ..".seq_id", "seq_id", base.DEC)
    offset = offset + 2
    -- reserved = ProtoField.uint16(NAME ..".reserved", "reserved", base.DEC)
    offset = offset + 2
    -- frag_mf_offset = ProtoField.uint32(NAME ..".frag_mf_offset", "frag_mf_offset", base.HEX)
    offset = offset + 4
    -- total_len = ProtoField.uint16(NAME ..".total_len", "total_len", base.DEC)
    headerSubtree:add(total_len, buffer(offset,2))
    offset = offset + 2
    -- table_id = ProtoField.uint16(NAME ..".table_id", "table_id", base.DEC)
    offset = offset + 2
    -- service_type = ProtoField.uint16(NAME ..".service_type", "service_type", base.DEC)
    offset = offset + 2
    -- policy_id = ProtoField.uint16(NAME ..".policy_id", "policy_id", base.DEC)
    offset = offset + 2
    -- start_time  = ProtoField.absolute_time(NAME .. ".start_time", "start_time")
    headerSubtree:add(start_time, buffer(offset,8)):append_text(" (CPU Clock mul * unix_nsec) ")
    offset = offset + 8
    -- cdr_id  = ProtoField.uint64(NAME .. ".cdr_id", "cdr_id")
    offset = offset + 8 
    -- device_id = ProtoField.uint8(NAME ..".device_id", "device_id", base.DEC)
    offset = offset + 1
    -- filter_flag = ProtoField.uint8(NAME ..".filter_flag", "filter_flag", base.DEC)
    offset = offset + 1
    -- data_type = ProtoField.uint8(NAME ..".data_type", "data_type", base.DEC)
    offset = offset + 1
    -- cup_clock_mul = ProtoField.uint8(NAME ..".cup_clock_mul", "cup_clock_mul", base.DEC)
    headerSubtree:add(cpu_clock_mul, buffer(offset,1)):append_text(" (CPU Clock 100MHz) ")
    offset = offset + 1
    -- bcd_flag = ProtoField.uint8(NAME ..".bcd_flag", "bcd_flag", base.DEC)
    offset = offset + 1
    -- reserved_1 = ProtoField.uint8(NAME ..".reserved_1", "reserved_1", base.DEC)
    offset = offset + 1
    -- reserved_2 = ProtoField.uint8(NAME ..".reserved_2", "reserved_2", base.DEC)
    offset = offset + 1
    -- reserved_3 = ProtoField.uint8(NAME ..".reserved_3", "reserved_3", base.DEC)
    offset = offset + 1
    offset = 44;
    -- header len is 44

    -- common info
    offset = 44 + 367
    -- uint8_t     imsi[16];//IMSI OR NAI
    -- uint8_t     imei[18];//IMEI OR IMEISV
    -- uint8_t     msisdn[24];//MSISDN
    -- uint8_t     suci[24];//
    -- uint64_t    start_time;
    -- uint8_t     dnn[32]; 
    offset = offset - 32
    commonSubtree:add(dnn, buffer(offset, 32)):append_text(" (DATA NETWORK NAME)")
    offset = offset - 8 - 24 - 24
    commonSubtree:add(msisdn, buffer(offset, 24)):append_text(" (phone number)")
    offset = offset - 18
    commonSubtree:add(imei, buffer(offset, 18)):append_text(" (device imei)")
    offset = offset - 16
    commonSubtree:add(imsi, buffer(offset, 18)):append_text(" (phome imsi)")



    offset = 44 + 367
    cdrSubtree:add(delay_time, buffer(offset,8)):append_text(" (delay time ".. buffer(offset,8):uint64()/1000000  .." ms) ")
    offset = offset + 8 +1
    local cdr_id = buffer(offset, 1):le_uint()
    local cdr_desc = get_cdr_description(cdr_id)
    cdrSubtree:add(type, buffer(offset,1)):append_text("(" .. cdr_desc .. ")")
    offset = offset + 1 + 1
    local direction_id = buffer(offset,1):uint()
    if direction_id == 1 then  cdr_desc = "UE to NETWORK"
    elseif direction_id == 2 then cdr_desc = "NETWORK to UE" end
    
    cdrSubtree:add(direction, buffer(offset,1)):append_text("(" .. cdr_desc .. ")")




end

local udpTable = DissectorTable.get("udp.port")
udpTable:add(6666, ng_cdr_Protocol)