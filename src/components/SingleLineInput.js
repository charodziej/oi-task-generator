import React from 'react'
import { TextField } from '@material-ui/core'

export default function SingleLineInput({ value, onChange, label, type }) {
    return (
        <TextField
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
            type={type}
        />
    )
}
