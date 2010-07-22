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

# Class defining a time event that pauses execution of the script until a
# certain time. Times should be given as a 24 hour string seperated by
# colons, i.e. 21 or 11:30 or 0:26:15. Minutes and seconds are optional.
class TimeEvent < Event

     def initialize(comment, *value)
        super
     end

     # Executes the command. pauses execution and tests passed value against
     # system time every second until there is a match.
     def exec()
         hour = Time.now.hour
         minute = Time.now.min
         second = Time.now.sec

         time = @value.split(":")

         sleep(1) unless hour == time[0] and (minute == time[1] or time.length < 2) and (second == time[2] or time.length < 3)
     end

     def to_s
         return "Sleep until time: #{@value}#{" -- " if RUBY_PLATFORM.match(/mswin/i) or RUBY_PLATFORM.match(/mingw/i)}\n#{@comment}"
     end
end
