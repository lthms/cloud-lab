{{- define "miniflux.fullname" -}}
{{- .Release.Name }}
{{- end -}}

{{- define "miniflux.labels" -}}
app.kubernetes.io/name: miniflux
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "miniflux.selectorLabels" -}}
app.kubernetes.io/name: miniflux
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
