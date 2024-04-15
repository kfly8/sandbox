import { css } from 'hono/css'

export type ButtonProps = {
  size?: 'small' | 'medium' | 'large';
  label: string;
}

export const createButtonProps = (params: URLSearchParams) : ButtonProps => {
  return {
    size: params.get('size') as ButtonProps['size'],
    label: params.get('label') as ButtonProps['label'],
  }
}

export const Button = ({
  size = 'medium',
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
