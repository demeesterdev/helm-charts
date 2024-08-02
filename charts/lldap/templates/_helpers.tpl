{{/*
Expand the name of the chart.
*/}}
{{- define "chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "chart.fullname" -}}
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
{{- define "chart.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "chart.labels" -}}
helm.sh/chart: {{ include "chart.chart" . }}
{{ include "chart.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "chart.selectorLabels" -}}
app.kubernetes.io/name: {{ include "chart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "chart.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "chart.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Build the connectionstring being used to connect to the backend
*/}}
{{- define "chart.databaseURL" -}}
{{- if eq .Values.database.type "sqlite" -}}
sqlite:///
{{- .Values.database.connection | trimPrefix "/" -}}
?mode=rwc
{{- else if eq .Values.database.type "postgres" -}}
{{- .Values.database.connection }}
{{- end -}}
{{- end }}

{{/*
Build the secret references
*/}}
{{- define "chart.ldapUserSecretName" }}
{{- if .Values.ldapAdmin.existingSecret.name }}
{{- .Values.ldapAdmin.existingSecret.name }}
{{- else -}}
{{- printf "%s-user" (include "chart.fullname" . ) -}}
{{- end }}
{{- end }}

{{- define "chart.ldapUserSecretkey.username" }}
{{- if .Values.ldapAdmin.existingSecret.name }}
{{- required ".Values.ldapAdmin.existingSecret.key.username is required" .Values.ldapAdmin.existingSecret.key.username}}
{{- else -}}
username
{{- end }}
{{- end }}

{{- define "chart.ldapUserSecretkey.email" }}
{{- if .Values.ldapAdmin.existingSecret.name }}
{{- required ".Values.ldapAdmin.existingSecret.key.email is required" .Values.ldapAdmin.existingSecret.key.email}}
{{- else -}}
email
{{- end }}
{{- end }}

{{- define "chart.ldapUserSecretkey.password" }}
{{- if .Values.ldapAdmin.existingSecret.name }}
{{- required ".Values.ldapAdmin.existingSecret.key.password is required" .Values.ldapAdmin.existingSecret.key.password}}
{{- else -}}
password
{{- end }}
{{- end }}
