{{- define "n8n.fullname" -}}
{{- .Release.Name }}
{{- end -}}

{{- define "n8n.labels" -}}
app.kubernetes.io/name: n8n
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "n8n.selectorLabels" -}}
app.kubernetes.io/name: n8n
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
