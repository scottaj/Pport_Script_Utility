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

require 'event'
require 'pport'
include Pport

# Class defining an event that reads a hardware address and waits fora change
# to the value read to continue execution.
class ReadEvent < Event

    def initialize(comment, *value)
        super
    end

    # Calls platform appropriate code for communication with the port and
    # reads data from it.
    def exec(address)
        loop do
            reader = GenPport.new(address)
            val = reader.read()
            if @value[0] < 0
                break if val != reader.read
            else
                break if val == @value[0]
            end
            sleep(0.01)
        end
    end

    def to_s
        return "Wait for change to read address\n#{" -- " if RUBY_PLATFORM.match(/mswin/i) or RUBY_PLATFORM.match(/mingw/i)}#{@comment}" if @value[0] < 0
        return "Wait for read address to have value: #{@value}\n#{" -- " if RUBY_PLATFORM.match(/mswin/i) or RUBY_PLATFORM.match(/mingw/i)}#{@comment}"
    end
end
