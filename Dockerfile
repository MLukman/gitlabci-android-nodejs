FROM mlukman/gitlab-ci-android:latest
MAINTAINER Muhammad Lukman Nasaruddin <anatilmizun@gmail.com>

ENV ANDROID_BUILD_TOOLS "28.0.3"

RUN ANDROID_BUILD_TOOLS_MAX=$(sdkmanager --sdk_root=$ANDROID_HOME --list| grep "build-tools;" | grep -v "rc"| tail -1 | cut -d';' -f2 | cut -d' ' -f1)
RUN install-sdk \
	"platform-tools" \
	"build-tools;${ANDROID_BUILD_TOOLS_MAX:-$ANDROID_BUILD_TOOLS}" \
	"extras;android;m2repository" \
	"extras;google;m2repository" \
	"extras;google;google_play_services"

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash && \
	curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
	echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
	apt-get update && \
	apt-get install -y nodejs yarn jq git

RUN dpkg --purge --force-depends ca-certificates-java && apt-get install ca-certificates-java
