#
# Copyright (C) 2022 PolarMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

declare -a TARGET_PRIVACY_OVERRIDE_PACKAGES=()

droidbuild_module(){
  LOCAL_PATH=$(dirname $BASH_SOURCE)
  DROIDBUILD_POSTRUN_MODULES+=$LOCAL_PATH
}

droidbuild_postrun(){
  LOCAL_PATH=$(dirname $BASH_SOURCE)
  info "Generating SystemUI privacy exception list."
  OUT_FILE=$LOCAL_PATH/packages/SystemUI/res/values/privacy_override.xml
  exec "rm -f $OUT_FILE"
  exec "touch $OUT_FILE"
  echo "<resources>" >> $OUT_FILE
  echo '<string-array name="packages_privacy_override">' >> $OUT_FILE
  for package in ${TARGET_PRIVACY_OVERRIDE_PACKAGES[@]}; do
    info "Adding $package"
    echo "<item>$package</item>" >> $OUT_FILE
  done
  echo "</string-array>" >> $OUT_FILE
  echo "</resources>" >> $OUT_FILE
  success "Finished generating SystemUI privacy exception list"
}
