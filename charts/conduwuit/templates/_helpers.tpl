{{- define "conduwuit.fullname" -}}
{{- .Release.Name }}
{{- end -}}

{{- define "conduwuit.labels" -}}
app.kubernetes.io/name: conduwuit
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "conduwuit.selectorLabels" -}}
app.kubernetes.io/name: conduwuit
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
