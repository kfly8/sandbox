import { css } from 'hono/css'

interface ButtonProps {
  primary?: boolean;
  backgroundColor?: string;
  size?: 'small' | 'medium' | 'large';
  label: string;
  onClick?: () => void;
}

export const Button = ({
  primary = false,
  size = 'medium',
  backgroundColor,
  label,
  ...props
} : ButtonProps) => {

  const buttonBaseClass = css`
    padding: 10px 20px;
  `

  const buttonSize = {
    large: css`font-size: 20px;`,
    medium: css`font-size: 16px;`,
    small: css`font-size: 12px;`,
  }

  const buttonClass = css`${buttonBaseClass} ${buttonSize[size]}`

  return (
    <>
      <button class={buttonClass} {...props}>{label}</button>
    </>
  );
}
