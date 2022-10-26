describe("Home page", () => {
  it("renders homepage", () => {
    cy.visit("/");
  });
});
describe("Product details", () => {
  it("should go to product detail page by clicking on a product", () => {
    cy.get(".products article").first().find("img").click();
    cy.contains("The Scented Blade is an extremely rare, tall plant").should(
      "exist"
    );
  });
});
