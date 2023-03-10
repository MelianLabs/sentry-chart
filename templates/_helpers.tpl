{{/*
Expand the name of the chart.
*/}}
{{- define "sentry.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}

{{- define "sentry.clickHouse.fullname" -}}
{{- default .Chart.Name .Values.clickHouse.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "sentry.clickHouse.labels" -}}
helm.sh/chart: {{ include "sentry.chart" . }}
{{ include "sentry.clickHouse.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "sentry.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "sentry.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "sentry.labels" -}}
helm.sh/chart: {{ include "sentry.chart" . }}
{{ include "sentry.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "sentryCron.labels" -}}
helm.sh/chart: {{ include "sentry.chart" . }}
{{ include "sentryCron.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "sentryWorker.labels" -}}
helm.sh/chart: {{ include "sentry.chart" . }}
{{ include "sentryWorker.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "sentry.selectorLabels" -}}
app.kubernetes.io/name: {{ include "sentry.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "sentry.clickHouse.selectorLabels" -}}
app.kubernetes.io/name: "clickHouse"
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "sentryCron.selectorLabels" -}}
app.kubernetes.io/name: {{ include "sentry.name" . }}-cron
app.kubernetes.io/instance: {{ .Release.Name }}-cron
{{- end }}

{{- define "sentryWorker.selectorLabels" -}}
app.kubernetes.io/name: {{ include "sentry.name" . }}-worker
app.kubernetes.io/instance: {{ .Release.Name }}-worker
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "sentry.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "sentry.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "sentry.clickHouse.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default .Values.clickHouse.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}