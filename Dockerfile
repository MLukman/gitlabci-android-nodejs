FROM mlukman/gitlab-ci-android:latest
MAINTAINER Muhammad Lukman Nasaruddin <anatilmizun@gmail.com>

ENV ANDROID_PLATFORM_VERSION "26"
ENV ANDROID_BUILD_TOOLS "27.0.3"

RUN install-sdk \
	"platform-tools" \
	"platforms;android-${ANDROID_PLATFORM_VERSION}" \
	"build-tools;${ANDROID_BUILD_TOOLS}" \
	"extras;android;m2repository" \
	"extras;google;m2repository" \
	"extras;google;google_play_services"

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash && \
	apt-get install -y nodejs yarn