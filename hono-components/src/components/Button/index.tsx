import { css } from 'hono/css'

export type ButtonProps = {
  size: 'small' | 'medium' | 'large';
  children: any;
}

export const Button = ({ size, children }: ButtonProps) => {

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
      <button class={buttonClass}>{children}</button>
    </>
  );
}

