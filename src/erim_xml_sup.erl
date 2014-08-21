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

%% @author Jean Parpaillon <jean.parpaillon@free.fr>

%% @doc
%% The module <strong>{@module}</strong> is the master supervisor.
%%
%% <p>
%% It will start the following services:
%% </p>
%% <ol>
%%   <li>{@link erim_xml}</li>
%% </ol>
%%
%% <p>
%% It's not intended to be used directly.
%% </p>

-module(erim_xml_sup).

-behaviour(supervisor).

%% Initialization.
-export([
	 start_link/0
	]).

%% supervisor(3erl) callbacks.
-export([
	 init/1
	]).

-define(SUPERVISOR, ?MODULE).

%% --------------------------------------------------------------------
%% Public API.
%% --------------------------------------------------------------------

%% @spec () -> Result
%%     Result = term()
%% @doc Start the supervisor and link to it.
%%
%% @see supervisor:start_link/3.

start_link() ->
    supervisor:start_link({local, ?SUPERVISOR}, ?MODULE, []).

%% --------------------------------------------------------------------
%% supervisor(3erl) callbacks.
%% --------------------------------------------------------------------

%% @hidden

init(_Args) ->
    %% XML.
    XML = {xml,
	   {erim_xml, start_link, []},
	   transient,
	   2000,
	   worker,
	   [erim_xml]
	  },
    {ok, {{one_for_one, 10, 1}, [XML]}}.
