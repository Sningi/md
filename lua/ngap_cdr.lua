local NAME = "ng_cdr"

ng_cdr_Protocol = Proto("ng_cdr", "CDR for N1N2")

-- Header fields

local header_len = ProtoField.uint16(NAME ..".header_len", "header_len", base.DEC)
local msg_type = ProtoField.uint16(NAME ..".msg_type", "msg_type", base.DEC)
local seq_id = ProtoField.uint16(NAME ..".seq_id", "seq_id", base.DEC)
local reserved = ProtoField.uint16(NAME ..".reserved", "reserved", base.DEC)
local frag_mf_offset = ProtoField.uint32(NAME ..".frag_mf_offset", "frag_mf_offset", base.HEX)

local total_len = ProtoField.uint16(NAME ..".total_len", "total_len", base.DEC)
local table_id = ProtoField.uint16(NAME ..".table_id", "table_id", base.DEC)
local service_type = ProtoField.uint16(NAME ..".service_type", "service_type", base.DEC)
local policy_id = ProtoField.uint16(NAME ..".policy_id", "policy_id", base.DEC)

local start_time  = ProtoField.uint64(NAME .. ".start_time", "start_time",base.DEC)
local cdr_id  = ProtoField.uint64(NAME .. ".cdr_id", "cdr_id")
local device_id = ProtoField.uint8(NAME ..".device_id", "device_id", base.DEC)
local filter_flag = ProtoField.uint8(NAME ..".filter_flag", "filter_flag", base.DEC)
local data_type = ProtoField.uint8(NAME ..".data_type", "data_type", base.DEC)
local cpu_clock_mul = ProtoField.uint8(NAME ..".cpu_clock_mul", "cpu_clock_mul", base.DEC)
local bcd_flag = ProtoField.uint8(NAME ..".bcd_flag", "bcd_flag", base.DEC)
local reserved_1 = ProtoField.uint8(NAME ..".reserved_1", "reserved_1", base.DEC)
local reserved_2 = ProtoField.uint8(NAME ..".reserved_2", "reserved_2", base.DEC)
local reserved_3 = ProtoField.uint8(NAME ..".reserved_3", "reserved_3", base.DEC)
-- header

-- common info
local amf_ue_ngap_id  = ProtoField.uint64(NAME .. ".amf_ue_ngap_id", "amf_ue_ngap_id\t",base.DEC)
local ran_ue_ngap_id  = ProtoField.uint32(NAME .. ".ran_ue_ngap_id", "ran_ue_ngap_id\t",base.DEC)
local amf_region_id = ProtoField.uint8(NAME ..".amf_region_id", "amf_region_id\t", base.DEC)
local amf_set_id = ProtoField.uint16(NAME ..".amf_set_id", "amf_set_id\t", base.DEC)
local amf_pointer = ProtoField.uint8(NAME ..".amf_pointer", "amf_pointer\t", base.DEC)
local fiveg_tmsi  = ProtoField.uint32(NAME .. ".fiveg_tmsi", "fiveg_tmsi\t",base.DEC)

local amf_ipv4  = ProtoField.ipv4(NAME .. ".amf_ipv4", "amf_ipv4\t",base.DEC)
local amf_ipv6  = ProtoField.ipv6(NAME .. ".amf_ipv6", "amf_ipv6\t",base.DEC)
local amf_port  = ProtoField.uint16(NAME ..".amf_port", "amf_port\t", base.DEC)

local gnb_ipv4  = ProtoField.ipv4(NAME .. ".gnb_ipv4", "gnb_ipv4\t",base.DEC)
local gnb_ipv6  = ProtoField.ipv6(NAME .. ".gnb_ipv6", "gnb_ipv6\t",base.DEC)
local gnb_port  = ProtoField.uint16(NAME ..".gnb_port", "gnb_port\t", base.DEC)

local upf_ipv4  = ProtoField.ipv4(NAME .. ".upf_ipv4", "upf_ipv4\t",base.DEC)
local upf_ipv6  = ProtoField.ipv6(NAME .. ".upf_ipv6", "upf_ipv6\t",base.DEC)
local upf_teid  = ProtoField.uint32(NAME .. ".upf_teid", "upf_teid\t",base.DEC)

local gnb_gtp_ipv4  = ProtoField.ipv4(NAME .. ".gnb_gtp_ipv4", "gnb_gtp_ipv4\t",base.DEC)
local gnb_gtp_ipv6  = ProtoField.ipv6(NAME .. ".gnb_gtp_ipv6", "gnb_gtp_ipv6\t",base.DEC)
local gnb_gtp_teid  = ProtoField.uint32(NAME .. ".gnb_gtp_teid", "gnb_gtp_teid\t",base.DEC)

local add_upf_ipv4  = ProtoField.ipv4(NAME .. ".add_upf_ipv4", "add_upf_ipv4\t",base.DEC)
local add_upf_ipv6  = ProtoField.ipv6(NAME .. ".add_upf_ipv6", "add_upf_ipv6\t",base.DEC)
local add_upf_teid  = ProtoField.uint32(NAME .. ".add_upf_teid", "add_upf_teid\t",base.DEC)

local add_gnb_gtp_ipv4  = ProtoField.ipv4(NAME .. ".add_gnb_gtp_ipv4", "add_gnb_gtp_ipv4\t",base.DEC)
local add_gnb_gtp_ipv6  = ProtoField.ipv6(NAME .. ".add_gnb_gtp_ipv6", "add_gnb_gtp_ipv6\t",base.DEC)
local add_gnb_gtp_teid  = ProtoField.uint32(NAME .. ".add_gnb_gtp_teid", "add_gnb_gtp_teid\t",base.DEC)

local pdu_address_v6  = ProtoField.ipv6(NAME .. ".pdu_address_v6", "pdu_address_v6\t",base.DEC)
local pdu_address_v4  = ProtoField.ipv4(NAME .. ".pdu_address_v4", "pdu_address_v4\t",base.DEC)

local location_type = ProtoField.uint8(NAME ..".location_type", "location_type\t", base.DEC)
local mcc = ProtoField.uint16(NAME ..".mcc", "mcc\t", base.DEC)
local mnc = ProtoField.uint16(NAME ..".mnc", "mnc\t", base.DEC)
local tac  = ProtoField.uint32(NAME .. ".tac", "tac\t",base.DEC)
local ci  = ProtoField.uint64(NAME .. ".ci", "ci\t",base.DEC)
local cipher_alg_id = ProtoField.uint8(NAME ..".cipher_alg_id", "cipher_alg_id\t", base.DEC)
-- local suci_ng  = ProtoField.string(NAME .. ".suci", "SUCI\t")
local start_time_ng  = ProtoField.uint64(NAME .. ".start_time", "start_time",base.DEC)

local imei_ng  = ProtoField.string(NAME .. ".imei", "IMEI\t")
local imsi_ng  = ProtoField.string(NAME .. ".imsi", "IMSI\t")
local msisdn_ng  = ProtoField.string(NAME .. ".msisdn", "MSISDN\t")
local dnn  = ProtoField.string(NAME .. ".dnn", "DNN\t")
-- small cdr
CDR= "cdr"
local delay_time  = ProtoField.uint64(CDR .. ".delay_time", "delay_time")
local cause  = ProtoField.uint8(CDR .. ".cause", "cause", base.HEX)
local cdr_result  = ProtoField.uint8(CDR .. ".result", "result", base.HEX)

local type  = ProtoField.uint8(CDR .. ".type", "type", base.HEX)
local msg_type  = ProtoField.uint8(CDR .. ".msg_type", "msgtype", base.HEX)
local direction  = ProtoField.uint8(CDR .. ".direction", "direction", base.DEC)

local mnc = ProtoField.uint16(NAME ..".mnc", "mnc\t", base.DEC)
local tac  = ProtoField.uint32(NAME .. ".tac", "tac\t",base.HEX)
local ci  = ProtoField.uint64(NAME .. ".ci", "ci\t",base.HEX)
-- mm cdr
local access_type = ProtoField.uint8(NAME ..".access_type", "access_type\t", base.DEC)
local authen_type = ProtoField.uint8(NAME ..".authen_type", "authen_type\t", base.DEC)
local cipher_algo = ProtoField.uint8(NAME ..".cipher_algo", "cipher_algo\t", base.DEC)
local new_amf_region_id = ProtoField.uint8(NAME ..".new_amf_region_id", "new_amf_region_id\t", base.DEC)
local new_amf_set_id = ProtoField.uint16(NAME ..".new_amf_set_id", "new_amf_set_id\t", base.DEC)
local new_amf_pointer = ProtoField.uint8(NAME ..".new_amf_pointer", "new_amf_pointer\t", base.DEC)
local new_fiveg_tmsi = ProtoField.uint32(NAME ..".new_fiveg_tmsi", "new_fiveg_tmsi\t", base.DEC)
local ngap_cause_type = ProtoField.uint8(NAME ..".ngap_cause_type", "ngap_cause_type\t", base.DEC)
local ngap_cause = ProtoField.uint8(NAME ..".ngap_cause", "ngap_cause\t", base.DEC)
-- sm cdr

local pdu_session_id = ProtoField.uint8(NAME ..".pdu_session_id", "pdu_session_id\t", base.DEC)
local old_pdu_session_id = ProtoField.uint8(NAME ..".old_pdu_session_id", "old_pdu_session_id\t", base.DEC)
local ssc_mode = ProtoField.uint8(NAME ..".ssc_mode", "ssc_mode\t", base.DEC)
local select_ssc_mode = ProtoField.uint8(NAME ..".select_ssc_mode", "select_ssc_mode\t", base.DEC)
local select_pdu_session_type = ProtoField.uint8(NAME ..".select_pdu_session_type", "select_pdu_session_type\t", base.DEC)

local s_nssai_sd = ProtoField.uint32(NAME ..".s_nssai_sd", "s_nssai_sd\t", base.DEC)
local s_nssai_sst = ProtoField.uint8(NAME ..".s_nssai_sst", "s_nssai_sst\t", base.DEC)
local req_cause = ProtoField.uint8(NAME ..".req_cause", "req_cause\t", base.DEC)

local ngap_cause_type = ProtoField.uint8(NAME ..".ngap_cause_type", "ngap_cause_type\t", base.DEC)
local ngap_cause = ProtoField.uint8(NAME ..".ngap_cause", "ngap_cause\t", base.DEC)

-- ho cdr
local other_location_type  = ProtoField.uint8(CDR .. ".other_location_type", "target_location_type", base.DEC)
local other_tac  = ProtoField.uint32(NAME .. ".other_tac", "target_tac\t",base.HEX)
local other_ci  = ProtoField.uint64(NAME .. ".other_ci", "target_ci\t",base.HEX)

local ran_node_id_len  = ProtoField.uint8(CDR .. ".ran_node_id_len", "ran_node_id_len\t", base.DEC)
local ran_node_id  = ProtoField.uint32(NAME .. ".ran_node_id", "ran_node_id\t",base.DEC)
-- local req_cause = ProtoField.uint8(NAME ..".mnc", "mnc\t", base.DEC)

ng_cdr_Protocol.fields = {
    header_len,msg_type,seq_id,reserved,frag_mf_offset,total_len,table_id,
    service_type,policy_id,start_time,cdr_id,device_id,data_type,cpu_clock_mul,
    bcd_flag,reserved_1,reserved_2,reserved_3, filter_flag,     --cdr header
    -- common info
    imei_ng,imsi_ng,msisdn_ng,dnn,amf_ue_ngap_id,ran_ue_ngap_id,amf_region_id,amf_set_id,amf_pointer,fiveg_tmsi,
    amf_ipv4,amf_ipv6,amf_port,gnb_ipv4,gnb_ipv6,gnb_port,
    upf_ipv4,upf_ipv6,upf_teid,gnb_gtp_ipv4,gnb_gtp_ipv6,gnb_gtp_teid,
    add_upf_ipv4,add_upf_ipv6,add_upf_teid,add_gnb_gtp_ipv4,add_gnb_gtp_ipv6,add_gnb_gtp_teid,
    pdu_address_v6,pdu_address_v4,location_type,mcc,mnc,tac,ci, cipher_alg_id,start_time_ng,
    -- small info
    delay_time,type,direction,cause,cdr_result,

    -- mm cdr
    access_type,authen_type,cipher_algo,
    new_amf_region_id,new_amf_set_id,new_amf_pointer,new_fiveg_tmsi,
    ngap_cause_type,ngap_cause,
    -- sm cdr
    pdu_session_id,old_pdu_session_id,
    ssc_mode,
    select_ssc_mode,
    select_pdu_session_type,

    s_nssai_sd,
    s_nssai_sst,

    req_cause,
    -- handover cdr

    other_location_type, other_tac,other_ci,
    ran_node_id_len,ran_node_id
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
        -- mm
    elseif cdrid == 0xc1 then cdr_desc = "SM_EST"
    elseif cdrid == 0xc9 then cdr_desc = "SM_MOD"
    elseif cdrid == 0xd1 then cdr_desc = "SM_RELEASE"
        -- sm
    elseif cdrid == 0x01 then cdr_desc = "HO_OUT"
    elseif cdrid == 0x02 then cdr_desc = "HO_IN"
        -- ho
    elseif cdrid == 0xff then cdr_desc = "UE_CONTEXT_RELEASE" end
    return cdr_desc
end

function ng_cdr_Protocol.dissector(buffer, pinfo, tree)
    -- return false
    if buffer:len() > 396 then local cdr_id = buffer(396, 1):le_uint()
        local cdr_desc = get_cdr_description(cdr_id)
        if cdr_desc == "Unknown CDR" then return false end
    else return false
    end
    pinfo.cols.protocol = ng_cdr_Protocol.name
    local subtree = tree:add(ng_cdr_Protocol, buffer(), "NG CDR Data")
    local headerSubtree = subtree:add(ng_cdr_Protocol, buffer(0,44),    "Header         len:44")
    local commonSubtree = subtree:add(ng_cdr_Protocol, buffer(44, 343), "COMMON CDR     len:343")
    local len = buffer:len()-44-343
    local cdrSubtree = subtree:add(ng_cdr_Protocol, buffer(44+343,len), "SMALL CDR      len:" .. len .. "")

    -- CDR Header
    local offset = 0
    headerSubtree:add(header_len, buffer(offset,2)):append_text("\t\t[len must 44]")
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
    local stime = buffer(offset,8):uint64():tonumber()
    headerSubtree:add(start_time, buffer(offset,8)):append_text("[CPU Clock mul * unix_nsec]")
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
    local ccm = buffer(offset,1):uint64():tonumber()
    headerSubtree:add(cpu_clock_mul, buffer(offset,1)):append_text("\t\t[CPU Clock 100MHz]")
    headerSubtree:append_text(string.format("\t[start time: %s.%d]", os.date("%Y-%m-%d %H:%M:%S", stime/1000000000),stime%1000000000))
    offset = offset + 1
    -- bcd_flag = ProtoField.uint8(NAME ..".bcd_flag", "bcd_flag", base.DEC)
    offset = offset + 1
    -- reserved_1 = ProtoField.uint8(NAME ..".reserved_1", "reserved_1", base.DEC)
    offset = offset + 1
    -- reserved_2 = ProtoField.uint8(NAME ..".reserved_2", "reserved_2", base.DEC)
    offset = offset + 1
    -- reserved_3 = ProtoField.uint8(NAME ..".reserved_3", "reserved_3", base.DEC)
    offset = offset + 1
    offset = 44,
    -- header len is 44

    -- common info
    commonSubtree:add_le(amf_ue_ngap_id, buffer(offset,8))
    offset = offset + 8
    commonSubtree:add_le(ran_ue_ngap_id, buffer(offset,4))
    offset = offset + 4
    commonSubtree:add_le(amf_region_id, buffer(offset,1))
    offset = offset + 1
    commonSubtree:add_le(amf_set_id, buffer(offset,2))
    offset = offset + 2
    commonSubtree:add_le(amf_pointer, buffer(offset,1))
    offset = offset +1
    commonSubtree:add(fiveg_tmsi, buffer(offset,4))
    offset = offset + 4

    local ngap_tree = commonSubtree:add(ng_cdr_Protocol, buffer(offset, 32), "N2 INTERFACE")
    local addr_upper = buffer(offset+8 ,8):uint64():tonumber()
    if addr_upper == 0 then
        ngap_tree:add(amf_ipv4, buffer(offset,4))
    else 
        ngap_tree:add(amf_ipv6, buffer(offset,16))
    end
    offset = offset + 16
    ngap_tree:add(amf_port, buffer(offset,2))
    offset = offset + 2

    local addr_upper = buffer(offset+8 ,8):uint64():tonumber()
    if addr_upper == 0 then
        ngap_tree:add(gnb_ipv4, buffer(offset,4))
    else 
        ngap_tree:add(gnb_gtp_ipv6, buffer(offset,16))
    end
    offset = offset + 16
    ngap_tree:add(gnb_port, buffer(offset,2))
    offset = offset +2

    local gtp_tunnel_tree = commonSubtree:add(ng_cdr_Protocol, buffer(offset, 96), "GTP TUNNEL")
    gtp_tunnel_tree:add(upf_ipv6, buffer(offset,16))
    offset = offset+16
    gtp_tunnel_tree:add(upf_ipv4, buffer(offset,4))
    offset = offset + 4
    gtp_tunnel_tree:add(upf_teid, buffer(offset,4))
    offset = offset + 4

    gtp_tunnel_tree:add(gnb_gtp_ipv6, buffer(offset,16))
    offset = offset+16
    gtp_tunnel_tree:add(gnb_gtp_ipv4, buffer(offset,4))
    offset = offset + 4
    gtp_tunnel_tree:add(gnb_gtp_teid, buffer(offset,4))
    offset = offset + 4
    
    gtp_tunnel_tree:add(add_upf_ipv6, buffer(offset,16))
    offset = offset+16
    gtp_tunnel_tree:add(add_upf_ipv4, buffer(offset,4))
    offset = offset + 4
    gtp_tunnel_tree:add(add_upf_teid, buffer(offset,4))
    offset = offset + 4

    gtp_tunnel_tree:add(add_gnb_gtp_ipv6, buffer(offset,16))
    offset = offset+16
    gtp_tunnel_tree:add(add_gnb_gtp_ipv4, buffer(offset,4))
    offset = offset + 4
    gtp_tunnel_tree:add(add_gnb_gtp_teid, buffer(offset,4))
    offset = offset + 4
    
    commonSubtree:add(pdu_address_v6, buffer(offset, 16))
    offset = offset + 16
    commonSubtree:add(pdu_address_v4, buffer(offset, 4))
    offset = offset + 4
    local lt = buffer(offset, 1):uint64():tonumber()
    local ltdsc = "UNKNOWN TYPE"
    if lt == 1 then ltdsc = "NR"
    elseif lt == 2 then ltdsc = "E-UTRAN"
    elseif lt == 3 then ltdsc = "N3IWF" end
    commonSubtree:add_le(location_type, buffer(offset, 1)):append_text("\t[ "..ltdsc.." ]")
    offset = offset + 1

    commonSubtree:add_le(mcc, buffer(offset, 2))
    offset = offset + 2
    
    commonSubtree:add_le(mnc, buffer(offset, 2))
    offset = offset + 2
    commonSubtree:add(tac, buffer(offset, 4))
    offset = offset + 4

    commonSubtree:add_le(ci, buffer(offset, 8))
    offset = offset + 8


    offset = 44 + 343

    offset = offset - 8
    offset = offset - 32
    commonSubtree:add(dnn, buffer(offset, 32))
    -- offset = offset - 24 
    -- commonSubtree:add(suci_ng, buffer(offset, 24))
    offset = offset- 24
    commonSubtree:add(msisdn_ng, buffer(offset, 24))
    offset = offset - 18
    commonSubtree:add(imei_ng, buffer(offset, 18))
    offset = offset - 16
    commonSubtree:add(imsi_ng, buffer(offset, 16))



    offset = 44 + 343
    local dtime = buffer(offset,8):uint64():tonumber()

    cdrSubtree:add(delay_time, buffer(offset,8)):append_text(string.format("\t[%.3f ms]",dtime/1000000))
    offset = offset + 8
    cdrSubtree:add(cause, buffer(offset,1))
    offset = offset +1
    local cdr_id = buffer(offset, 1):le_uint()
    local cdr_desc = get_cdr_description(cdr_id)
    if cdr_desc == "Unknown CDR" then return false end
    cdrSubtree:add(type, buffer(offset,1)):append_text("\t\t[" .. cdr_desc .. "]")
    offset = offset + 1
    cdrSubtree:add(msg_type, buffer(offset,1))
    offset = offset + 1
    local tr = buffer(offset,1):uint64():tonumber()
    if tr == 1 then cdr_desc = "SUCCESS"
    elseif tr==2 then cdr_desc = "FAILED"
    else cdr_desc = "UNKNOWN" end
    cdrSubtree:add(cdr_result, buffer(offset,1)):append_text("\t\t[" .. cdr_desc .. "]")
    
    offset = offset + 1
    local direction_id = buffer(offset,1):uint()
    if direction_id == 1 then  cdr_desc = "UE to NETWORK"
    elseif direction_id == 2 then cdr_desc = "NETWORK to UE" end
    cdrSubtree:add(direction, buffer(offset,1)):append_text("\t\t[" .. cdr_desc .. "]")
    offset = offset + 1
    if (0x41<=cdr_id and cdr_id<=0x5d) or cdr_id == 0xff then
        cdrSubtree:add(access_type, buffer(offset,1))
        offset = offset + 1
        cdrSubtree:add(authen_type, buffer(offset,1))
        offset = offset + 1
        cdrSubtree:add(cipher_algo, buffer(offset,1))
        offset = offset + 1
        cdrSubtree:add(new_amf_region_id, buffer(offset,1))
        offset = offset + 1
        cdrSubtree:add_le(new_amf_set_id, buffer(offset,2))
        offset = offset + 2
        cdrSubtree:add(new_amf_pointer, buffer(offset,1))
        offset = offset + 1
        cdrSubtree:add(new_fiveg_tmsi, buffer(offset,4))
        offset = offset + 4
        cdrSubtree:add(ngap_cause_type, buffer(offset,1))
        offset = offset + 1
        cdrSubtree:add(ngap_cause, buffer(offset,1))

    elseif cdr_id== 0xc1 or cdr_id == 0xc9 or cdr_id == 0xd1 then
        cdrSubtree:add(pdu_session_id, buffer(offset,1))
    else
        cdrSubtree:add(other_location_type, buffer(offset,1))
        offset = offset + 1
        cdrSubtree:add(other_tac, buffer(offset,4))
        offset = offset + 4
        cdrSubtree:add_le(other_ci, buffer(offset,8))
        offset = offset + 8
        cdrSubtree:add(req_cause, buffer(offset,1))
        offset = offset + 1
        cdrSubtree:add(ran_node_id_len, buffer(offset,1))
        offset = offset + 1
        cdrSubtree:add(ran_node_id, buffer(offset,4))
    end
end

local udpTable = DissectorTable.get("udp.port")
udpTable:add(6666, ng_cdr_Protocol)