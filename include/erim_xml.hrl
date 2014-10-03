%% Copyright ProcessOne 2006-2010. All Rights Reserved.
%% Copyright Jean Parpaillon 2014. All Rights Reserved.
%%
%% The contents of this file are subject to the Erlang Public License,
%% Version 1.1, (the "License"); you may not use this file except in
%% compliance with the License. You should have received a copy of the
%% Erlang Public License along with this software. If not, it can be
%% retrieved online at http://www.erlang.org/.
%%
%% Software distributed under the License is distributed on an "AS IS"
%% basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
%% the License for the specific language governing rights and limitations
%% under the License.
-ifndef(erim_xml_hrl).
-define(erim_xml_hrl, true).

% Defined by XML.
-define(NS_XML,                      'http://www.w3.org/XML/1998/namespace').
-define(NS_XML_s,                    "http://www.w3.org/XML/1998/namespace").
-define(NS_XML_b,                    <<"http://www.w3.org/XML/1998/namespace">>).
-define(NS_XML_pfx,                  "xml").

% --------------------------------------------------------------------
% Type definition.
% --------------------------------------------------------------------

% NS, element's name and attribute's name.
-type(xmlname() :: atom() | string()).
-type(attributename() :: binary()).

% Structures used by XML serialization functions.
-type(xmldefaultns()   :: xmlname() | [xmlname()]).
-type(xmldefaultnss()  :: [xmldefaultns()]).
-type(xmlprefixednss() :: [{xmlname(), string()}]).

% Path description (to be used in erim_xml:get_path/2).
-type(xmlpathcomponent() ::
  {element, xmlname()} |
  {element, xmlname(), xmlname()} |
  {attribute, xmlname()} |
  {attribute, xmlname(), xmlname()} |
  cdata |
  cdata_as_list).
-type(xmlpath() :: [xmlpathcomponent()]).

% --------------------------------------------------------------------
% Records to represent XML nodes.
% --------------------------------------------------------------------

% Note: The records defined here are documented in exmpp_xml.

% Character data.
-record(xmlcdata, {
  cdata = <<>>     :: binary()
}).
-type(xmlcdata() :: #xmlcdata{}).

% Attributes.
-record(xmlattr, {
  ns = undefined   :: xmlname() | undefined,
  name             :: attributename(),
  value            :: binary()
}).
-type(xmlattr() :: #xmlattr{}).

% Old attribute isn't represented by a record.
-type(xmlattr_old() :: {xmlname(), string()}).

% Elements.
-record(xmlel, {
  ns = undefined   :: xmlname() | undefined,
  declared_ns = [] :: [{xmlname(), string() | none}],
  name             :: xmlname(),
  attrs = []       :: [xmlattr()],
  children = []    :: [#xmlel{} | xmlcdata()] | undefined
}).
-type(xmlel() :: #xmlel{}).

% XML end tag.
% To use when 'children' is undefined in xmlel or xmlelement.
-record(xmlendtag, {
  ns = undefined   :: xmlname() | undefined,
  name             :: xmlname()
}).
-type(xmlendtag() :: #xmlendtag{}).

% Old record for xmlel.
-record(xmlelement, {
  name             :: xmlname(),
  attrs = []       :: [xmlattr_old()],
  children = []    :: [#xmlelement{} | xmlcdata()] | undefined
}).
-type(xmlel_old() :: #xmlelement{}).

% Processing Instruction.
-record(xmlpi, {
  target           :: binary(),
  value            :: binary()
}).
-type(xmlpi() :: #xmlpi{}).

-type(xmlattr_any() :: xmlattr() | xmlattr_old()).
-type(xmlel_any()   :: xmlel() | xmlel_old()).
-type(xmlnode()     :: xmlel() | xmlel_old() | xmlcdata()).

% --------------------------------------------------------------------
% Macros to help creation of XML nodes.
% --------------------------------------------------------------------

-define(XMLEL1(Name),
  erim_xml:element(Name)).
-define(XMLEL2(NS, Name),
  erim_xml:element(NS, Name)).
-define(XMLEL4(NS, Name, Attrs, Children),
  erim_xml:element(NS, Name, Attrs, Children)).

-define(XMLATTR(Name, Value),
  erim_xml:attribute(Name, Value)).

-define(XMLCDATA(CData),
  erim_xml:cdata(CData)).

-endif.
