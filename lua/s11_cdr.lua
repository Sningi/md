local NAME = "cdr_gtpv2"
gtpv2_cdr_Protocol = Proto("cdr_gtpv2","CDR for GTPv2")

local type_name = {
    -- public
    [0x0001] = "mcc",
    [0x0002] = "mnc",
    [0x0003] = "imsi",
    [0x0004] = "imei",
    [0x0005] = "caller",
    [0x0006] = "user_ipv4",
    [0x0007] = "user_ipv6",
    [0x0008] = "rat",
    [0x0009] = "action",
    [0x000A] = "time",
    [0x000B] = "cdr_result",
    [0x000C] = "fail_cause",
    [0x000D] = "apn_num",
    [0x000E] = "apn",
    -- epccommon
    [0x3000] = "guti",
    [0x3001] = "user_ipv4_epc",
    [0x3002] = "user_ipv6_epc",
    [0x3003] = "cur_ecgi",
    [0x3004] = "cur_tai",
    [0x3005] = "src_ecgi",
    [0x3006] = "src_tai",
    -- s11
    [0x4000] = "mme_c_ip",
    [0x4001] = "sgw_c_ip",
    [0x4002] = "mme_c_teid",
    [0x4003] = "sgw_c_teid",
    [0x4004] = "sgw_s58_c_ip",
    [0x4005] = "pgw_s58_c_ip",
    [0x4006] = "sgw_s58_c_teid",
    [0x4007] = "pgw_s58_c_teid",
    [0x4008] = "indication_flags",
    [0x4009] = "address_type",
    [0x400A] = "cg_address",
    [0x400B] = "charging_id",
    [0x400C] = "lbi",
    [0x400D] = "eps_bearer_number",
    [0x400E] = "change_reporting_action",
    [0x400F] = "req_cause",
    [0x4010] = "cause"
}

local header = ProtoField.bytes(NAME .. "header", "HEADER", base.SPACE)

local tlv_type = ProtoField.uint16(NAME .. ".type","Type",base.HEX,type_name)
local tlv_len = ProtoField.uint16(NAME .. ".length","Length")
local tlv_value = ProtoField.bytes(NAME .. ".value","Value")

-- specific value field
-- public
local mcc_s11 = ProtoField.string(NAME .. ".mcc_s11","MCC")
local mnc_s11 = ProtoField.string(NAME .. ".mnc_s11","MNC")
local imsi_s11 = ProtoField.uint64(NAME .. ".imsi_s11","IMSI")
local imei_s11 = ProtoField.string(NAME .. ".imei_s11","IMEI")
local caller_s11 = ProtoField.uint64(NAME .. ".caller_s11","CALLER")
local user_ipv4_s11 = ProtoField.ipv4(NAME .. ".user_ipv4_s11","User_IPv4")
local user_ipv6_s11 = ProtoField.ipv6(NAME .. ".user_ipv6_s11","User_IPv6")
local rat_s11 = ProtoField.uint8(NAME .. ".rat_s11","RAT")
local action_s11 = ProtoField.uint8(NAME .. ".action_s11","ACTION",base.HEX)
local time_s11 = ProtoField.uint32(NAME .. ".time_s11","TIME")
local cdr_result_s11 = ProtoField.uint8(NAME .. ".cdr_result_s11","CDR_RESULT")
local fail_cause_s11 = ProtoField.uint8(NAME .. ".fail_cause_s11","FAIL_CAUSE")
local apn_num_s11 = ProtoField.uint8(NAME .. ".apn_num_s11","APN_NUM")
local apn_s11 = ProtoField.string(NAME .. ".apn_s11","APN")
-- epccommon
local guti_s11 = ProtoField.string(NAME .. ".guti","GUTI_S11")
local user_ipv4_epc_s11 = ProtoField.ipv4(NAME .. ".user_ipv4","User_IPv4_epc_S11")
local user_ipv6_epc_s11 = ProtoField.ipv6(NAME .. ".user_ipv6","User_IPv6_epc_S11")
local cur_ecgi_s11 = ProtoField.string(NAME .. ".cur_ecgi","CUR_ECGI_S11")
local cur_tai_s11 = ProtoField.string(NAME .. ".cur_tai","CUR_TAI_S11")
local src_ecgi_s11 = ProtoField.string(NAME .. ".src_ecgi","SRC_ECGI_S11")
local src_tai_s11 = ProtoField.string(NAME .. ".src_tai","SRC_TAI_S11")

-- S11
local mme_c_ip_s11 = ProtoField.ipv4(NAME .. ".guti","MME_C_IP_S11")
local sgw_c_ip_s11 = ProtoField.ipv4(NAME .. ".user_ipv4","SGW_C_IP_S11")
local mme_c_teid_s11 = ProtoField.uint32(NAME .. ".user_ipv6","MME_C_TEID_S11")
local sgw_c_teid_s11 = ProtoField.uint32(NAME .. ".cur_ecgi","SGW_C_TEID_S11")
local sgw_s58_c_ip_s11 = ProtoField.ipv4(NAME .. ".cur_tai","SGW_S58_C_IP_S11")
local pgw_s58_c_ip_s11 = ProtoField.ipv4(NAME .. ".src_ecgi","PGW_S58_C_IP_S11")
local sgw_s58_c_teid_s11 = ProtoField.uint32(NAME .. ".src_tai","SGW_S58_C_TEID_S11")
local pgw_s58_c_teid_s11 = ProtoField.uint32(NAME .. ".guti","PGW_S58_C_TEID_S11")
local indication_flags_s11 = ProtoField.string(NAME .. ".user_ipv4","INDICATION_FLAGS_S11")
local address_type_s11 = ProtoField.uint8(NAME .. ".user_ipv6","ADDRESS_TYPE_S11")
local cg_address_s11 = ProtoField.ipv4(NAME .. ".cur_ecgi","CG_ADDRESS_S11")
local charging_id_s11 = ProtoField.string(NAME .. ".cur_tai","CHARGING_ID_S11")
local lbi_s11 = ProtoField.uint8(NAME .. ".src_ecgi","LBI_S11")
local eps_bearer_number_s11 = ProtoField.uint8(NAME .. ".user_ipv4","EPS_BEARER_NUMBER_S11")
local change_reporting_action_s11 = ProtoField.uint8(NAME .. ".user_ipv6","CHANGE_REPORTING_ACTION_S11")
local req_cause_s11 = ProtoField.uint8(NAME .. ".cur_ecgi","REQ_CAUSE_S11")
local cause_s11 = ProtoField.uint8(NAME .. ".cur_tai","CAUSE_S11")

--unknown value
local value8 = ProtoField.uint8(NAME .. ".value", "Value", base.HEX)
local value16 = ProtoField.uint16(NAME .. ".value", "Value", base.HEX)
local value32 = ProtoField.uint32(NAME .. ".value", "Value", base.HEX)


local typeFields = {
    [0x0001] = mcc_s11,
    [0x0002] = mnc_s11,
    [0x0003] = imsi_s11,
    [0x0004] = imei_s11,
    [0x0005] = caller_s11,
    [0x0006] = user_ipv4_s11,
    [0x0007] = user_ipv6_s11,
    [0x0008] = rat_s11,
    [0x0009] = action_s11,
    [0x000A] = time_s11,
    [0x000B] = cdr_result_s11,
    [0x000C] = fail_cause_s11,
    [0x000D] = apn_num_s11,
    [0x000E] = apn_s11,
    -- epccommon
    [0x3000] = guti_s11,
    [0x3001] = user_ipv4_epc_s11,
    [0x3002] = user_ipv6_epc_s11,
    [0x3003] = cur_ecgi_s11,
    [0x3004] = cur_tai_s11,
    [0x3005] = src_ecgi_s11,
    [0x3006] = src_tai_s11,
    -- s11
    [0x4000] = mme_c_ip_s11,
    [0x4001] = sgw_c_ip_s11,
    [0x4002] = mme_c_teid_s11,
    [0x4003] = sgw_c_teid_s11,
    [0x4004] = sgw_s58_c_ip_s11,
    [0x4005] = pgw_s58_c_ip_s11,
    [0x4006] = sgw_s58_c_teid_s11,
    [0x4007] = pgw_s58_c_teid_s11,
    [0x4008] = indication_flags_s11,
    [0x4009] = address_type_s11,
    [0x400A] = cg_address_s11,
    [0x400B] = charging_id_s11,
    [0x400C] = lbi_s11,
    [0x400D] = eps_bearer_number_s11,
    [0x400E] = change_reporting_action_s11,
    [0x400F] = req_cause_s11,
    [0x4010] = cause_s11
}
-- typeFormats is a array of functions, for example, typeFormats[0x0001] returns a function to get the string of param value 
local typeFormats = {
    [0x0001] = function (value)
        return value:string()
    end,
    [0x0002] = function (value)
        return value:string()
    end,
    [0x0003] = function (value)
        return value:uint64()    -- Address object
    end,
    [0x0004] = function (value)
        return value:string()
    end,
    [0x0005] = function (value)
        return value:uint64()
    end,
    [0x0006] = function (value)
        return value:ipv4()
    end,
    [0x0007] = function (value)
        return value:ipv6()
    end,
    [0x0008] = function (value)
        return value:string()
    end,
    [0x0009] = function (value)
        return value:string()
    end,
    [0x000A] = function (value)
        return value:string()
    end,
    [0x000B] = function (value)
        return value:string()
    end,
    [0x000C] = function (value)
        return value:string()
    end,
    [0x000D] = function (value)
        return value:string()
    end,
    [0x000E] = function (value)
        return value:string()
    end,
    -- epccommon
    [0x3000] = function (value)
        return value:string()
    end,
    [0x3001] = function (value)
        return value:ipv4()
    end,
    [0x3002] = function (value)
        return value:ipv6()
    end,
    [0x3003] = function (value)
        return value:string()     
    end,
    [0x3004] = function (value)
        return value:string()
    end,
    [0x3005] = function (value)
        return value:string()
    end,
    [0x3006] = function (value)
        return value:string()
    end,
    -- s11
    [0x4000] = function (value)
        return value:ipv4()
    end,
    [0x4001] = function (value)
        return value:ipv4()
    end,
    [0x4002] = function (value)
        return value:string()
    end,
    [0x4003] = function (value)
        return value:string()     
    end,
    [0x4004] = function (value)
        return value:ipv4()
    end,
    [0x4005] = function (value)
        return value:ipv4()
    end,
    [0x4006] = function (value)
        return value:string()
    end,
    [0x4007] = function (value)
        return value:string()
    end,
    [0x4008] = function (value)
        return value:string()
    end,
    [0x4009] = function (value)
        return value:string()
    end,
    [0x400A] = function (value)
        return value:ipv4()
    end,
    [0x400B] = function (value)
        return value:string()
    end,
    [0x400C] = function (value)
        return value:string()
    end,
    [0x400D] = function (value)
        return value:string()
    end,
    [0x400E] = function (value)
        return value:string()
    end,
    [0x400F] = function (value)
        return value:string()
    end,
    [0x4010] = function (value)
        return value:string()
    end
}

gtpv2_cdr_Protocol.fields = {
    header,
    tlv_type,tlv_len,tlv_value,
    mcc_s11,mnc_s11,imsi_s11,imei_s11,caller_s11,user_ipv4_s11,user_ipv6_s11,rat_s11,action_s11,time_s11,cdr_result_s11,fail_cause_s11,apn_num_s11,apn_s11,
    guti_s11,user_ipv4_epc_s11,user_ipv6_epc_s11,cur_ecgi_s11,cur_tai_s11,src_ecgi_s11,src_tai_s11,
    mme_c_ip_s11,sgw_c_ip_s11,mme_c_teid_s11,sgw_c_teid_s11,sgw_s58_c_ip_s11,pgw_s58_c_ip_s11,sgw_s58_c_teid_s11,pgw_s58_c_teid_s11,indication_flags_s11,address_type_s11,cg_address_s11,charging_id_s11,lbi_s11,eps_bearer_number_s11,change_reporting_action_s11,req_cause_s11,cause_s11,
    value8, value16, value32
}


function getFieldName(field)
    local fieldString = tostring(field)
    local i, j = string.find(fieldString, ": .* " .. NAME)
    --find the start and end of the :.NAME
    if i ~= nil then return string.sub(fieldString, i + 2, j - (1 + string.len(NAME))) 
    else return "Value" end
    -- get * content
end

function getFieldType(field)
    local fieldString = tostring(field)
    local i, j = string.find(fieldString, "ftypes.* " .. "base")
    if i ~= nil then return string.sub(fieldString, i + 7, j - (1 + string.len("base"))) end 
    -- get * content
end

function getFieldByType(tlv_type, tlv_len)
    local tmp_field = typeFields[tlv_type]
    if(tmp_field) then
        return tmp_field    -- specific value filed
    else
        if tlv_len == 4 then     -- common value field
            return value32
        elseif tlv_len == 2 then
            return value16
        elseif tlv_len == 1 then
            return value8
        else
            return value
        end
    end
end


function formatValue(tlv_type, tlv_value)
    local tmp_func = typeFormats[tlv_type]
    -- tmp_func is a fuction
    if(tmp_func) then
    -- is tmp_func exsits
        return tmp_func(tlv_value)
    else
        return ""
    end
end

function gtpv2_cdr_Protocol.dissector(buffer,pinfo,tree)
    -- pinfo.cols.protocol = gtpv2_cdr_Protocol.name
    -- local raw_header = buf(0,32)
    -- local start_type = buf(32,2)
    -- local start_len = buf(34,2)
    -- local start_value = buf(35,start_len)
    local buffer_len = buffer:len()
    if buffer_len <= 32 then return false end
    
    --set the name of protocol name
    pinfo.cols.protocol = gtpv2_cdr_Protocol.name

    --create a sub tree representing the gtpv2_cdr_Protocol data
    local subtree = tree:add(gtpv2_cdr_Protocol,buffer(),"CDR Protocol for Gtpv2")
    subtree:add_le(header,buffer(0,32))
    local offset = 0
    local payloadStart = 32
    while payloadStart + offset < buffer_len do 
        -- tlv format
        local tlvType = buffer(payloadStart + offset, 2):uint()
        local tlvLength = buffer(payloadStart + offset + 2, 2):uint()
        local valueContent = buffer(payloadStart + offset + 4, tlvLength-4)
        -- tlvField get the field registed in the fields
        -- getFieldByType(tlvType, tlvLength-4) notice "tlvLength-4"
        local tlvField = getFieldByType(tlvType, tlvLength-4)
        local fieldName = getFieldName(tlvField)
        local description
        local fieldType = getFieldType(tlvField)
        if fieldName == "Value"  then
            description = "TLV (tlv_type" .. ":" .. string.format("0x%x", tlvType) .. ")"
        else    
            description = fieldName .. ": " .. tostring(formatValue(tlvType, valueContent))
        end
        local tlvSubtree = subtree:add(gtpv2_cdr_Protocol, buffer(payloadStart+offset, tlvLength), description)
        tlvSubtree:add(tlv_type, buffer(payloadStart + offset, 2))
        tlvSubtree:add(tlv_len, buffer(payloadStart + offset + 2, 2))
        if tlvLength-4 > 0 then
            -- local fieldType = getFieldType(tlvField)
            tlvSubtree:add(tlvField, buffer(payloadStart + offset + 4, tlvLength-4))
        end
        offset = offset + tlvLength
    end
        
end

local udp_port = DissectorTable.get("udp.port")
udp_port:add(7777, gtpv2_cdr_Protocol)      -- udp broadcast port 