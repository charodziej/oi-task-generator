import React from 'react'
import { TextField } from '@material-ui/core'

export default function MultiLineInput({ value, onChange, label }) {
    return (
        <TextField
            multiline
            variant="filled"
            color="secondary"
            style={{
                display: "flex",
                flexGrow: 1,
                margin: "8px 0px"
            }}
            label={label}
            value={value}
            onChange={(evt) => onChange(evt.target.value)}
        />
    )
}
