export interface IProduct {
  id: string;
  name: string;
  category_id: string;
  description: string;
  price: number;
  discount: number;
  stock_quantity: number;
  tags: string[];
  unit: string;
}

export interface ICreateProductFormInput {
  id: string;
  name: string;
  category_id: string;
  description: string;
  price: number;
  discount: number;
  stock_quantity: number;
  tags: string;
  unit: string;
}
export interface IEditProductFormInput extends ICreateProductFormInput {}
