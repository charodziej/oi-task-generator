import React from 'react'
import { TextField, MenuItem } from '@material-ui/core'

export default function SelectInput({ value, onChange, label, options }) {
    return (
        <TextField
            select
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
        >
            {options.map(option => (
                <MenuItem key={option.value} value={option.value}>
                    {option.label}
                </MenuItem>
            ))}
        </TextField>
    )
}
