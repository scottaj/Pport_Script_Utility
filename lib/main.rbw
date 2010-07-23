#!/usr/bin/env ruby

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'rubygems'
require 'wx'
require 'wx_sugar'
require 'gui_main_event'
require 'gui'
require 'script'

include Wx
include GUI

class FwApp < App
    def on_init
        t = Timer.new(self, 55)
        evt_timer(55) {Thread.pass}
        t.start(10)
        GUIMainEvent.new.show
    end
end

def main
    FwApp.new.main_loop
end

main if __FILE__ == $0
