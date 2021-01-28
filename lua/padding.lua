local NAME = "Padding"
pad_protocol = Proto("Padding", "Padding for s1u")

-- Header fields

    -- uint32_t teid;                           4
    -- uint32_t rsv_teid;                       4
    -- uint32_t src_ip;//outer src ip           4
    -- uint32_t dst_ip;//outer dst ip           4
    -- uint8_t  msisdn[7];//phone number        7
    -- uint8_t  imei[7];//meid or imei, if imei, just first 14 bits     7
    -- uint8_t  imsi[7];                                                7 /37
    -- uint16_t tac;                            2
    -- uint8_t  baseid[6];                      6
    -- uint8_t  tag;                            1
    -- uint64_t reserve1;                       8
    -- uint16_t reserve2;                       2                         /19  /56

gtpu_teid = ProtoField.uint32(NAME ..".gtpu_teid", "gtpu_teid", base.HEX)
resv_teid = ProtoField.uint32(NAME ..".resv_teid", "resv_teid", base.HEX)
src_ipv4  = ProtoField.ipv4(NAME .. ".src_ipv4", "Src IPv4 Address")
dst_ipv4  = ProtoField.ipv4(NAME .. ".dst_ipv4", "Dst IPv4 Address")
msisdn  = ProtoField.uint64(NAME .. ".msisdn", "MSISDN")
imei  = ProtoField.uint64(NAME .. ".imei", "IMEI")
imsi  = ProtoField.uint64(NAME .. ".imsi", "IMSI")
tac = ProtoField.uint16(NAME ..".tac", "tac", base.HEX)
baseid = ProtoField.uint64(NAME ..".baseid", "baseid", base.HEX)
tag = ProtoField.uint8(NAME ..".tag", "tag", base.HEX)
resv1 = ProtoField.uint64(NAME ..".resv1", "resv1", base.HEX)
resv2 = ProtoField.uint16(NAME ..".resv2", "resv2", base.HEX)


pad_protocol.fields = {gtpu_teid, resv_teid, src_ipv4, dst_ipv4,msisdn,imei,imsi,tac, baseid, tag,resv1, resv2}

local function heuristic_checker(buffer, pinfo, tree)
    -- guard for length
    length = buffer:len()
    if length ~= 56 then return false end

    local recv_teid = buffer(4,4):uint()

    if recv_teid == 0
    then
        pad_protocol.dissector(buffer, pinfo, tree)
        return true
    else return false end
end

function pad_protocol.dissector(buffer, pinfo, tree)

    pinfo.cols.protocol = pad_protocol.name

    local subtree = tree:add(pad_protocol, buffer(), "S1U Pad Protocol Data")
    -- Header
    subtree:add(gtpu_teid, buffer(0,4))
    subtree:add(resv_teid, buffer(4,4)):append_text(" (resv teid is 0)")
    subtree:add(src_ipv4, buffer(8,4))
    subtree:add(dst_ipv4, buffer(12,4))

    subtree:add(msisdn, buffer(16,7))
    subtree:add(imei, buffer(23,7))
    subtree:add(imsi, buffer(30,7))
    subtree:add(tac, buffer(37,2))

    subtree:add(baseid, buffer(39,6))
    subtree:add(tag, buffer(45,1))
    -- subtree:add(resv1, buffer(46,8))
    -- subtree:add(resv2, buffer(54,2))
end

pad_protocol:register_heuristic("eth.trailer", heuristic_checker)