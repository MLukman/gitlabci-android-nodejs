FROM mlukman/gitlab-ci-android:latest
MAINTAINER Muhammad Lukman Nasaruddin <anatilmizun@gmail.com>

ENV ANDROID_BUILD_TOOLS "28.0.3"

RUN for line in $(sdkmanager --list); do if echo $line | grep -q "build-tools;" ; then ANDROID_BUILD_TOOLS=$(echo $line | cut -d';' -f2); fi; done

RUN install-sdk \
	"platform-tools" \
	"build-tools;${ANDROID_BUILD_TOOLS}" \
	"extras;android;m2repository" \
	"extras;google;m2repository" \
	"extras;google;google_play_services"

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash && \
	curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
	echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
	apt-get update && \
	apt-get install -y nodejs yarn jq git

RUN dpkg --purge --force-depends ca-certificates-java && apt-get install ca-certificates-java
