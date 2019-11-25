This project demonstrate the issue with GenerateTestConfig android gradle plugin tasks
that corrupts gradle cache and in consequence tests for subprojects.

## How to repro:
- clone
- cd into project directory
- ./showMeTheBug.sh

## How this happens.

Gradle caches all outpus for tasks marked as cachable tasks, so in case task
inputs are the very same, instead of running task outpus are copied from cache.

[GenerateTestConfig](https://android.googlesource.com/platform/tools/base/+/studio-master-dev/build-system/gradle-core/src/main/java/com/android/build/gradle/tasks/GenerateTestConfig.kt) marks
**build/intermediates/unit_test_config_directory/[buildConfig]/UnitTest/out/**
as its output folder - the problem this folder contains test_config.properties
that contain absolute paths to generated resources.

Now if the same subproject (e.g. git sub-repo) is used in 2 different projects,
the the first build will put test_config.properties into the cache, the second one will
pull that file from cache - hardwiring itself to the outputs of the first one.
In effect it simply uses resources not from project.

## How to fix it
Imho - this task should not be putting absolute paths inside any generated configuration
that can land in to cache. Either making task non cachable or using relative paths should do the trick.
