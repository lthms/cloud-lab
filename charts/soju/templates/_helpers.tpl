{{- define "soju.fullname" -}}
{{- .Release.Name }}
{{- end -}}

{{- define "soju.labels" -}}
app.kubernetes.io/name: soju
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "soju.selectorLabels" -}}
app.kubernetes.io/name: soju
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
