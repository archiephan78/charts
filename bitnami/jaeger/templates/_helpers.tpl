{{/* vim: set filetype=mustache: */}}


{{/*
Return the proper jaeger&trade; image name
*/}}
{{- define "jaeger.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "jaeger.imagePullSecrets" -}}
{{ include "common.images.pullSecrets" (dict "images" (list .Values.image .Values.volumePermissions.image .Values.backup.uploadProviders.google.image .Values.backup.uploadProviders.azure.image) "global" .Values.global) }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "jaeger.query.serviceAccountName" -}}
{{- if .Values.query.serviceAccount.enabled -}}
    {{ default (include "common.names.fullname" .) .Values.query.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.query.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Return the jaeger credentials secret.
*/}}
{{- define "jaeger.secretName" -}}
{{- if .Values.auth.existingSecret -}}
    {{- printf "%s" (tpl .Values.auth.existingSecret $) -}}
{{- else -}}
    {{- printf "%s" (include "common.names.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Return the jaeger&trade; configuration configmap.
*/}}
{{- define "jaeger.configmapName" -}}
{{- if .Values.jaeger.existingConfiguration -}}
    {{- printf "%s" (tpl .Values.jaeger.existingConfiguration $) -}}
{{- else -}}
    {{- printf "%s" (include "common.names.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Return the jaeger&trade; PVC name.
*/}}
{{- define "jaeger.claimName" -}}
{{- if .Values.persistence.existingClaim }}
    {{- printf "%s" (tpl .Values.persistence.existingClaim $) -}}
{{- else -}}
    {{- printf "%s" (include "common.names.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Return the jaeger&trade; initialization scripts configmap.
*/}}
{{- define "jaeger.initdbScriptsConfigmapName" -}}
{{- if .Values.jaeger.initdbScriptsCM -}}
    {{- printf "%s" (tpl .Values.jaeger.initdbScriptsCM $) -}}
{{- else -}}
    {{- printf "%s-initdb-scripts" (include "common.names.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Get the jaeger&trade; initialization scripts secret.
*/}}
{{- define "jaeger.initdbScriptsSecret" -}}
{{- printf "%s" (tpl .Values.jaeger.initdbScriptsSecret $) -}}
{{- end -}}
