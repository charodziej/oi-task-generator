import React from 'react'
import MultiLineInput from './MultiLineInput'
import { IconButton } from '@material-ui/core'
import ClearIcon from '@material-ui/icons/Clear';

export default function TestInput({ input, output, onChange, onRemove }) {
    return (
        <div 
            style={{
                display: "flex",
                flexDirection: "row"
            }}
        >
            <div style={{ marginRight: 8, width: "100%" }} >
                <MultiLineInput 
                    label="Input"
                    value={input}
                    onChange={(val) => onChange(val, 0)}
                />
            </div>
            <div style={{ marginRight: 8, width: "100%" }} >
                <MultiLineInput 
                    label="Output"
                    value={output}
                    onChange={(val) => onChange(val, 1)}
                />
            </div>
            <IconButton 
                style={{
                    margin: "auto",
                    width: 40,
                    height: 40,
                }}
                onClick={onRemove}
            >
                <ClearIcon />
            </IconButton>
        </div>
    )
}
