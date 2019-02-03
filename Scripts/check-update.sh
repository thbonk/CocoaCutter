
#!/bin/sh

#
# checkUpdate.sh
# CocoaCutter
#
# Created by Thomas Bonk on 15.03.18.
# Copyright © 2018 Thomas Bonk Softwareentwicklung. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

UPTODATE=`carthage outdated --xcode-warnings | grep "All dependencies are up to date."`

if [ -z "$UPTODATE" ]; then
echo "Updating Carthage dependencies."
carthage update --no-use-binaries --platform macOS
else
echo "Carthage dependencies are up to date."
fi
