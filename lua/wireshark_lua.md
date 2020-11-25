# Wireshark Lua 脚本解析自定义数据

​																											              <u>2020-11-25</u>

## 一.Wireshark 解码方式简述

##### 1.树形协议解码

支持灵活添加协议子树（ wireshark 工具栏-->视图-->分组详情）

##### 2.tvb 格式数据传递

向每一级子协议传递其注册的数据区域首地址，依据偏移灵活取用

```c
typedef struct _tvbuff_t{
  uint8_t	*ptr;    /*start pointer*/
  uint32_t 	length;  /*total length (bytes)*/
}tvbuff_t;
```

## 二.Lua 插件接口

##### 1. 声明协议字段格式

```lua
local NAME = "Padding"

dst_ipv4 = ProtoField.ipv4(NAME .. ".dst_ipv4", "Dst IPv4 Address")
msisdn   = ProtoField.uint64(NAME .. ".msisdn", "MSISDN")
tac 	 = ProtoField.uint16(NAME ..".tac", "tac", base.HEX)
```

Lua 语法之字符串拼接符号 ： ‘**..**‘

ProtoField.new(**arg1, arg2,arg3**):

​	**new**():  wireshark 支持的字段格式

​    **arg1** :  wireshark 过滤器格式

​    **arg2** :  字段显示名

​    **arg3** :  字段显示格式

API 详见 11.6.7：		[https://www.wireshark.org/docs/wsdg_html_chunked/lua_module_Proto.html#lua_class_ProtoField](https://www.wireshark.org/docs/wsdg_html_chunked/lua_module_Proto.html#lua_class_ProtoField)

------

**11.6.7.1. ProtoField.new(name, abbr, type, [valuestring], [base], [mask], [descr])**

Creates a new [`ProtoField`](https://www.wireshark.org/docs/wsdg_html_chunked/lua_module_Proto.html#lua_class_ProtoField) object to be used for a protocol field.

**Arguments**

- name

  Actual name of the field (the string that appears in the tree).

- abbr

  Filter name of the field (the string that is used in filters).

- type

  Field Type: one of: `ftypes.BOOLEAN`, `ftypes.CHAR`, `ftypes.UINT8`, `ftypes.UINT16`, `ftypes.UINT24`, `ftypes.UINT32`, `ftypes.UINT64`, `ftypes.INT8`, `ftypes.INT16`, `ftypes.INT24`, `ftypes.INT32`, `ftypes.INT64`, `ftypes.FLOAT`, `ftypes.DOUBLE` , `ftypes.ABSOLUTE_TIME`, `ftypes.RELATIVE_TIME`, `ftypes.STRING`, `ftypes.STRINGZ`, `ftypes.UINT_STRING`, `ftypes.ETHER`, `ftypes.BYTES`, `ftypes.UINT_BYTES`, `ftypes.IPv4`, `ftypes.IPv6`, `ftypes.IPXNET`, `ftypes.FRAMENUM`, `ftypes.PCRE`, `ftypes.GUID`, `ftypes.OID`, `ftypes.PROTOCOL`, `ftypes.REL_OID`, `ftypes.SYSTEM_ID`, `ftypes.EUI64` or `ftypes.NONE`.

- valuestring (optional)

  A table containing the text that corresponds to the values, or a table containing tables of range string values that corresponds to the values ({min, max, "string"}) if the base is `base.RANGE_STRING`, or a table containing unit name for the values if base is `base.UNIT_STRING`, or one of `frametype.NONE`, `frametype.REQUEST`, `frametype.RESPONSE`, `frametype.ACK` or `frametype.DUP_ACK` if field type is ftypes.FRAMENUM.

- base (optional)

  The representation, one of: `base.NONE`, `base.DEC`, `base.HEX`, `base.OCT`, `base.DEC_HEX`, `base.HEX_DEC`, `base.UNIT_STRING` or `base.RANGE_STRING`.

- mask (optional)

  The bitmask to be used.

- descr (optional)

  The description of the field.

**Returns**

The newly created [`ProtoField`](https://www.wireshark.org/docs/wsdg_html_chunked/lua_module_Proto.html#lua_class_ProtoField) object.

------

##### 2.buffer(offset, length) 数据

 offset 基于首地址的偏移长度（bytes），length 解析的数据长度(bytes)

##### 3.大小端解析

 报文数据：大端：**add()** ，小端：**add_le()** 

##### 4.向协议树中注册自定义协议

##### 5.协议解码函数，添加解析字段的实例

完整流程代码

```lua
local NAME = "Padding"
pad_protocol = Proto("Padding", "Padding for s1u")

resv_teid = ProtoField.uint32(NAME ..".resv_teid", "resv_teid", base.HEX)
dst_ipv4 = ProtoField.ipv4(NAME .. ".dst_ipv4", "Dst IPv4 Address")
msisdn   = ProtoField.uint64(NAME .. ".msisdn", "MSISDN")
tac 	 = ProtoField.uint16(NAME ..".tac", "tac", base.HEX)

pad_protocol.fields = {resv_teid,dst_ipv4,msisdn,tac,}

local function heuristic_checker(buffer, pinfo, tree)
    -- guard for length
    length = buffer:len()
    if length ~= 56 then return false end
    -- check resv_teid value
    local rs_teid = buffer(4,4):uint()

    if rs_teid == 0
    then
        pad_protocol.dissector(buffer, pinfo, tree)
        return true
    else return false end

end

function pad_protocol.dissector(buffer, pinfo, tree)

    pinfo.cols.protocol = pad_protocol.name
    -- 向父树添加自定义协议，获取子树
    local subtree = tree:add(pad_protocol, buffer(), "S1U Pad Protocol Data")
    -- 向子树添加字段实例
    subtree:add(resv_teid, buffer(4,4)):append_text(" (resv teid is 0)")
    subtree:add(dst_ipv4, buffer(12,4))
    subtree:add(msisdn, buffer(16,7))
    subtree:add(tac, buffer(37,2))
    -- 其他字段略

end

-- 启发模式注册，无端口绑定，注册到eth padding层
pad_protocol:register_heuristic("eth.trailer", heuristic_checker)
```

##### 6.端口注册模式

```lua
-- 从全局解析表中获取udp.port解析表，将自定义协议注册到指定端口
local udpTable = DissectorTable.get("udp.port")
udpTable:add(6666, ng_cdr_Protocol)
```

##### 7.解析树分离显示

参数二选择的数据域，效果为点击协议树时，十六进制字节流蓝色着重标注区域

```lua
  local subtree = tree:add(ng_cdr_Protocol, buffer(), "NG CDR Data")
  local headerSubtree = subtree:add(ng_cdr_Protocol, buffer(0,44),    "Header       len:44")
  local commonSubtree = subtree:add(ng_cdr_Protocol, buffer(44, 367), "COMMON CDR   len:367")
  local len = buffer:len()-44-367
  local cdrSubtree = subtree:add(ng_cdr_Protocol, buffer(44+367,len), "SMALL CDR    len:" .. len .. "")
```

显示结果，

<img src="./samll_cdr.png" style="zoom:67%;" />

##### 8.解析器初始化

文件目录为wireshark 安装目录，修改文件 init.lua，于文件尾部添加插件，插件放置于同目录

```lua
dofile(DATA_DIR.."padding.lua")
dofile(DATA_DIR.."ngap_cdr.lua")
```



 