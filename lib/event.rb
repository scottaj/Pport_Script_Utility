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

# A class defining a generic script event, subclass will define specific
# types of events and should be used in scripts.
class Event

    # 
    def initialize(comment, *value)
        @value = value
        @comment = comment    
    end
    
    attr_reader :value, :comment

    def to_s
        return "Value: #{@value}#{" -- " if RUBY_PLATFORM.match(/mswin/i) or RUBY_PLATFORM.match(/mingw/i)}\n#{@comment}"
    end
end
