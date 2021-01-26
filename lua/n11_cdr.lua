local NAME = "n11_cdr"

n11_cdr_Protocol = Proto("n11_cdr", "CDR for N11")

-- Header fields

-- uint8_t  type;         //过程类型  -1
-- uint8_t  subtype;      //子类型  -1
-- uint8_t  result;       //过程状态  1
-- uint8_t  http_req;     //首条HTTP Request消息的类型  -1
-- uint8_t  http_result;  //http状态码  -1
-- uint8_t  req_reason;   //请求原因  -1
-- uint8_t  fail_reason;  //失败原因  -1
-- uint8_t  reqtype_n11;  //请求类型    -1
-- uint64_t  frist_delay; //响应时长  -1
-- uint64_t  total_delay; //CDR总时长  0
-- uint8_t  pdu_sid;      //PDU Session ID  0
-- uint8_t  pdu_stype;    //PDU Session Type   -1
-- uint8_t  access_type;  //接入网类型  -1
-- uint8_t  uelocation;   //位置类型   -1
-- uint8_t  snssai_sst;   //Snssai sst  -1
-- uint8_t  snssai_sd[6];   //Snssai sd  NULL
-- uint8_t  dnn[DNN__LEN];     //数据网络名称  NULL
-- uint8_t  supi[SUPI__LEN];   //SUPI  NULL
-- uint8_t  pei[PEI__LEN];     //PEI   NULL
-- uint8_t  gpsi[GPSI__LEN];   //GPSI  NULL
-- uint8_t  suci[SUCI__LEN];   //SUCI  NULL
-- uint16_t  amf_port;    //AMF端口号   0
-- uint16_t  smf_port;    //SMF端口号   0
-- uint16_t  mcc;         //MCC   -1
-- uint16_t  mnc;         //MNC   -1
-- uint32_t  amf_id;      //guami->amfId
-- uint32_t  n3_upf_ip4;
-- uint32_t  n3_upf_teid; //N3接口UPF侧的TEID  0
-- uint32_t  n3_an_ip4;
-- uint32_t  n3_an_teid;  //N3接口AN侧的TEID   0
-- uint32_t  usr_ip4;
-- uint32_t  tac;         //TAC   -1
-- uint64_t  cell_id;     //Cell ID   -1
-- ip_addr_t  amf_ip;   //AMF IP地址  0
-- ip_addr_t  smf_ip;   //SMF IP地址  0
-- ip_addr_t n3_upf_ip6;   //N3接口UPF侧的IP地址  0
-- ip_addr_t n3_an_ip6;    //N3接口AN侧的IP地址  0
-- ip_addr_t usr_ip6;      //终端用户的IP地址  0

n11_cdr_type = ProtoField.uint8(NAME ..".cdr_type", "cdr_type", base.DEC)
n11_msg_type = ProtoField.uint8(NAME ..".msg_type", "msg_type", base.DEC)
n11_cdr_result = ProtoField.uint8(NAME ..".cdr_result", "cdr_result", base.DEC)


n11_cdr_Protocol.fields = {
    n11_cdr_type,n11_msg_type,n11_cdr_result
}

function n11_cdr_Protocol.dissector(buffer,pinfo,tree)
    pinfo.cols.protocol = n11_cdr_Protocol.name
    local subtree = tree:add(n11_cdr_Protocol,buffer(),"N11 CDR Data")
end

local udpTable = DissectorTable.get("udp.port")
udpTable:add(8888,n11_cdr_Protocol)