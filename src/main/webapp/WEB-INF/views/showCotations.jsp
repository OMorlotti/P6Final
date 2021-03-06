<%@ include file="../jsp/header.jsp" %>

<h4>Liste des cotations</h4>

<spring:if test="${sessionScope.currentUser.role eq 'ADMIN'}">
<button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#cotationform">Ajouter une cotation</button>
</spring:if>

<div class="card mt-1 collapse" id="cotationform">
    <div class="card-body">
        <form method="POST" action="/Escalade/cotation">

            <div class="form-group row">
                <label class="col-sm-2 col-form-label" for="name">Nom :</label>
                <div class="col-sm-10">
                    <input class="form-control form-control-sm" type="text" name="name" id="name" required="required" />
                </div>
            </div>

            <div class="text-right">
                <button class="btn btn-primary" type="submit">Envoyer</button>
            </div>

        </form>
    </div>
</div>

<table class="table table-sm table-striped mt-2">
    <thead>
        <tr>
            <td>Cotations</td>
            <spring:if test="${sessionScope.currentUser.role eq 'ADMIN'}">
            <td></td>
            <td></td>
            </spring:if>
        </tr>
    </thead>
    <tbody>
        <spring:forEach var="cotation" items="${ cotations }">
        <tr>
            <td><spring:out value="${ cotation.name }" /></td>
            <spring:if test="${sessionScope.currentUser.role eq 'ADMIN'}">
            <td><a href="/Escalade/cotation/<spring:out value="${ cotation.id }" />">Voir/Editer</a></td>
            <td><a href="/Escalade/cotation/delete/<spring:out value="${ cotation.id }" />">Supprimer</a></td>
            </spring:if>
        </tr>
        </spring:forEach>
    </tbody>
</table>

<%@ include file="../jsp/footer.jsp" %>