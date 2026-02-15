{{- define "soap-coffee.fullname" -}}
{{- .Release.Name }}
{{- end -}}

{{- define "soap-coffee.labels" -}}
app.kubernetes.io/name: soap-coffee
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "soap-coffee.selectorLabels" -}}
app.kubernetes.io/name: soap-coffee
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
