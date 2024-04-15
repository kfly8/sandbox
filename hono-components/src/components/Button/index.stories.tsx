import type { StoryObj, Meta } from '@storybook/html';
import type { ButtonProps } from '.';
import { Button } from '.';

const meta = {
  title: 'Example/Button',
  tags: ['autodocs'],
  render: () => {
    console.log(Button);
    return "<div>hello</div>";
  },
  argTypes: {
    size: {
      control: { type: 'select' },
      options: ['small', 'medium', 'large'],
    },
  },
  args: {
  },
} satisfies Meta<ButtonProps>;

export default meta;
type Story = StoryObj<ButtonProps>;

export const Large: Story = {
  args: {
    size: 'large',
  },
};

export const Small: Story = {
  args: {
    size: 'small',
  },
};
